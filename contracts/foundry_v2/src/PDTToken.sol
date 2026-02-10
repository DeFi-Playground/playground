// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ERC20 } from "solady/tokens/ERC20.sol";

contract PDTToken is ERC20 {

  constructor(
    uint256 initialSupply
  ) {
    _mint(msg.sender, initialSupply);
  }

  function name() public pure override returns (string memory) {
    return "PlaygroundDefiToken";
  }

  function symbol() public pure override returns (string memory) {
    return "PDT";
  }

  function decimals() public pure override returns (uint8) {
    return 18;
  }
}
