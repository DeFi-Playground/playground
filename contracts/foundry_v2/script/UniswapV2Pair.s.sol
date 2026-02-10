// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {IUniswapV2Pair} from "v2-core/interfaces/IUniswapV2Pair.sol";

contract UniswapV2PairScript is Script {

  address public usdppdtPair = 0x486c627015838998A04e7742399700ff50643656;

  function setUp() public {}  

  function run() public {
    (uint minimumLiquidity) = IUniswapV2Pair(usdppdtPair).MINIMUM_LIQUIDITY();
    (address factory) = IUniswapV2Pair(usdppdtPair).factory();
    (address token0) = IUniswapV2Pair(usdppdtPair).token0();
    (address token1) = IUniswapV2Pair(usdppdtPair).token1();
    (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast) = IUniswapV2Pair(usdppdtPair).getReserves();
    (uint price0CumulativeLast) = IUniswapV2Pair(usdppdtPair).price0CumulativeLast();
    (uint price1CumulativeLast) = IUniswapV2Pair(usdppdtPair).price1CumulativeLast();
    (uint kLast) = IUniswapV2Pair(usdppdtPair).kLast();

    console.log("===========");
    console.log("MINIMUM_LIQUIDITY");
    console.logUint(minimumLiquidity);
    console.log("===========");
    console.log("Factory");
    console.logAddress(factory);
    console.log("===========");
    console.log("Token0");
    console.logAddress(token0);
    console.log("===========");
    console.log("Token1");
    console.logAddress(token1);
    console.log("===========");
    console.log("Reserve0");
    console.logUint(reserve0);
    console.log("Reserve1");
    console.logUint(reserve1);
    console.log("blockTimestampLast");
    console.logUint(blockTimestampLast);
    console.log("price0CumulativeLast");
    console.logUint(price0CumulativeLast);
    console.log("price1CumulativeLast");
    console.logUint(price1CumulativeLast);
    console.log("kLast");
    console.logUint(kLast);
    console.log("===========");

    (uint liquidity) = IUniswapV2Pair(usdppdtPair).mint(0x0d76b138023D1B901a155f491CE245736729893a);
    console.log("liquidity");
    console.logUint(liquidity);
  }
}
