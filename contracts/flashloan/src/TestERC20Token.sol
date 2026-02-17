// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ERC20 } from "solady/tokens/ERC20.sol";

contract TestERC20Token is ERC20 {

  constructor(
    uint256 initialSupply
  ) {
    _mint(msg.sender, initialSupply);
  }

  function name() public pure override returns (string memory) {
    return "TestERC20Token";
  }

  function symbol() public pure override returns (string memory) {
    return "TET";
  }

  function decimals() public pure override returns (uint8) {
    return 18;
  }
}
