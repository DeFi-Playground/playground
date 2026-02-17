// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {FlashBorrower} from "../src/FlashBorrower.sol";
import {SimpleVault} from "../src/SimpleVault.sol";
import {TestERC20Token} from "../src/TestERC20Token.sol";

contract FlashBorrowerTest is Test {
  FlashBorrower public flashBorrower;
  SimpleVault public simpleVault;
  TestERC20Token public token;

  uint256 public supply = 1_000e18;

  function setUp() public {
    token = new TestERC20Token(100_000e18);
    flashBorrower = new FlashBorrower();
    simpleVault = new SimpleVault(address(flashBorrower));

    flashBorrower.setLender(address(simpleVault));
    token.transfer(address(simpleVault), supply);
    token.transfer(address(flashBorrower), supply);

  }

  function test_MaxFlashLoan() public {
    assertEq(
      simpleVault.maxFlashLoan(address(token)),
      supply
    );
  }

  function test_FlashLoan() public {
    uint256 balanceBefore = token.balanceOf(
      address(flashBorrower)
    );

    flashBorrower.flashBorrow(
      address(token),
      supply
    );

    uint256 balanceAfter = token.balanceOf(
      address(flashBorrower)
    );
    assertLt(balanceAfter, balanceBefore);
  }
}
