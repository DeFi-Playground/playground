// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {IUniswapV2Pair} from "v2-core/interfaces/IUniswapV2Pair.sol";
import {IUniswapV2Router02} from "v2-periphery/interfaces/IUniswapV2Router02.sol";
import {IERC20} from "v2-periphery/interfaces/IERC20.sol";

contract UniswapV2Router02ReadOnlyScript is Script {

    address public router02 = 0x920b806E40A00E02E7D2b94fFc89860fDaEd3640;
    address public usdp = 0x255b030F3d2b8023C7aCc11A5A25C768a4F99Af4;
    address public pdt = 0x08bBB4a9D79b8399852cE870a901577a939c9983;
    address public sender = 0xECcEfbCE887DBdc1c393A409BaAb153F3380a364;
    address public pair = 0x486c627015838998A04e7742399700ff50643656;

    function getQuote(uint amountA) internal returns (uint amountB) {
      (uint reserveA, uint reserveB,) = getReserves();
      (amountB) = IUniswapV2Router02(router02).quote(
        amountA,
	// reserveA,
	reserveB,
	reserveA
      );
    }

    function getReserves() internal returns (uint112 reserveA, uint112 reserveB, uint32 blockTimestampLast) {
      (reserveA, reserveB, blockTimestampLast) = IUniswapV2Pair(pair).getReserves();
    }

    function getAmountOut(uint amountIn) internal returns (uint amountOut) {
      (uint reservePDT, uint reserveUSDP, ) = getReserves();
      (amountOut) = IUniswapV2Router02(router02).getAmountOut(
        amountIn,
	reserveUSDP,
	reservePDT
      );
    }

    function getAmountIn(uint amountOut) internal returns (uint amountIn) {
      (uint reservePDT, uint reserveUSDP, ) = getReserves();
      (amountIn) = IUniswapV2Router02(router02).getAmountIn(
        amountOut,
	reserveUSDP,
	reservePDT
      );
    }

    function getAmountsOut(uint amountIn) internal returns (uint[] memory amountsOut) {
      address[] memory paths = new address[](1);
      paths[0] = pair;
      (amountsOut) = IUniswapV2Router02(router02).getAmountsOut(
        amountIn,
	paths
      );
    }

    function getAmountsIn(uint amountOut) internal returns (uint[] memory amountsIn) {
      address[] memory paths = new address[](1);
      paths[0] = pair;
      (amountsIn) = IUniswapV2Router02(router02).getAmountsIn(
        amountOut,
	paths
      );
    }

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

	uint amountADesired = 100e6;
	uint amountBDesired = 500e18;
	uint amountAMin = 90e6;
	uint amountBMin = 480e18;
	uint deadline = block.timestamp + 60;
	
	// allowance
	IERC20(usdp).approve(router02, amountADesired);
	IERC20(pdt).approve(router02, amountBDesired);

	(uint amountA, uint amountB, uint liquidity) = IUniswapV2Router02(router02).addLiquidity(
	  usdp,
	  pdt,
	  amountADesired,
	  amountBDesired,
	  amountAMin,
	  amountBMin,
	  sender,
	  deadline
	);

	console.log("========");
	console.log("Add Liquidity");
	console.log("========");
	console.log("amountA");
	console.log(amountA);
	console.log("========");
	console.log("amountB");
	console.log(amountB);
	console.log("========");
	console.log("liquidity");
	console.log(liquidity);
	console.log("========");
	console.log("Pair ERC20 Balance");
	(uint256 pairERC20Balance) = IERC20(pair).balanceOf(sender);
	console.logUint(pairERC20Balance);
	console.log("========");

	console.log("===========");
	console.log("Getting Quote of 100e6 amountA");
	uint amountBQuote = getQuote(100e6);
	console.logUint(amountBQuote);
	console.log("===========");

        console.log("===========");
	console.log("Getting Amount Out");
	uint amountOut = getAmountOut(1e6);
	console.logUint(amountOut);
	console.log("===========");

	console.log("===========");
	console.log("Getting Amount In");
	uint amountIn = getAmountIn(5e18);
	console.logUint(amountIn);
	console.log("===========");
	
	/*
	console.log("===========");
	console.log("Getting Amounts Out");
	uint[] memory amountsOut = getAmountsOut(1e6);
	console.logUint(amountsOut[0]);
	console.log("===========");

	console.log("===========");
	console.log("Getting Amounts In");
	uint[] memory amountsIn = getAmountsIn(5e18);
	console.logUint(amountsIn[0]);
	console.log("===========");
        */

	console.log("===========");
	(address weth) = IUniswapV2Router02(router02).WETH();
	console.log("WETH");
	console.logAddress(weth);
	console.log("===========");
    }
}
