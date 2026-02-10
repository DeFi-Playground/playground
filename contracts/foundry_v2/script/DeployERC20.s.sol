// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {USDPToken} from "../src/USDPToken.sol";
import {PDTToken} from "../src/PDTToken.sol";

contract DeployERC20 is Script {
  USDPToken public usdp;
  PDTToken public pdt;
  
  function setUp() public {}

  function run() public {
    vm.startBroadcast();

    usdp = new USDPToken(1000e6);
    pdt = new PDTToken(1000e18);

    console.log(address(usdp));
    console.log(usdp.balanceOf(msg.sender));

    console.log(address(pdt));
    console.log(pdt.balanceOf(msg.sender));

    vm.stopBroadcast();
  }
}
