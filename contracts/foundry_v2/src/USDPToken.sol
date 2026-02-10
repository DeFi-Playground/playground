// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ERC20 } from "solady/tokens/ERC20.sol";

contract USDPToken is ERC20 {

  constructor(
    uint256 initialSupply
  ) {
    _mint(msg.sender, initialSupply);
  }

  function name() public pure override returns (string memory) {
    return "USDPlaygroundToken";
  }

  function symbol() public pure override returns (string memory) {
    return "USDP";
  }

  function decimals() public pure override returns (uint8) {
    return 6;
  }
}
