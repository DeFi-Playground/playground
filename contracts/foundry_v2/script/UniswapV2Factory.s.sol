// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IUniswapV2Factory} from "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";

error PairFound();

contract UniswapV2FactoryScript is Script {
  address public factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
  address public usdp = 0x255b030F3d2b8023C7aCc11A5A25C768a4F99Af4;
  address public pdt = 0x08bBB4a9D79b8399852cE870a901577a939c9983;

  function logExistingPair(address pair) public {
    (address feeTo) = IUniswapV2Factory(factory).feeTo();
    (address feeToSetter) = IUniswapV2Factory(factory).feeToSetter();

    console.log("=========");
    console.log("Pair Address");
    console.logAddress(pair);
    console.log("=========");

    console.log("FeeTo");
    console.logAddress(feeTo);
    console.log("=========");
      
    console.log("FeeToSetter");
    console.logAddress(feeToSetter);
    console.log("=========");
  }

  function setUp() public {}

  function run() public {
    console.log("=========");
    console.log("USDP Token");
    console.logAddress(usdp);
    console.log("=========");
    console.log("PDT Token");
    console.logAddress(pdt);
    console.log("=========");

    vm.startBroadcast();

    (address pair) = IUniswapV2Factory(factory).getPair(usdp, pdt);

    if (pair != address(0)) {
      logExistingPair(pair);
      revert PairFound();
    }
    
    console.log("There is no Pair contract deployed for these tokens");

    console.log("Deploying one...");

    (address deployedPair) = IUniswapV2Factory(factory).createPair(usdp, pdt);

    console.log("Deployed Pair Address");
    console.logAddress(deployedPair);
    console.log("=========");

    logExistingPair(deployedPair);

    vm.stopBroadcast();
  }
}
