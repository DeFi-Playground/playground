// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {IUniswapV2Router02} from "v2-periphery/interfaces/IUniswapV2Router02.sol";
import {IERC20} from "v2-periphery/interfaces/IERC20.sol";

contract UniswapV2Router02Script is Script {

    address public router02 = 0x920b806E40A00E02E7D2b94fFc89860fDaEd3640;
    address public usdp = 0x255b030F3d2b8023C7aCc11A5A25C768a4F99Af4;
    address public pdt = 0x08bBB4a9D79b8399852cE870a901577a939c9983;
    address public sender = 0xECcEfbCE887DBdc1c393A409BaAb153F3380a364;
    address public pair = 0x486c627015838998A04e7742399700ff50643656;

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

	// approval
	IERC20(pair).approve(router02, liquidity);

	(uint amountAReceived, uint amountBReceived) = IUniswapV2Router02(router02).removeLiquidity(
	  usdp,
	  pdt,
	  liquidity,
	  0,
	  0,
	  sender,
	  deadline
	);

	console.log("========");
	console.log("Remove Liquidity");
	console.log("========");
        console.log("Amount A Received");
        console.logUint(amountAReceived);
        console.log("Emission");
        console.logUint(amountA - amountAReceived);
	console.log("========");
	console.log("Amount B Received");
        console.logUint(amountBReceived);
	console.log("Emission");
        console.logUint(amountB - amountBReceived);
	console.log("========");

        vm.stopBroadcast();
    }
}
