// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {IUniswapV2Router02} from "v2-periphery/interfaces/IUniswapV2Router02.sol";
import {IERC20} from "v2-periphery/interfaces/IERC20.sol";

contract UniswapV2Router02SwapScript is Script {

    address public router02 = 0x920b806E40A00E02E7D2b94fFc89860fDaEd3640;
    address public usdp = 0x255b030F3d2b8023C7aCc11A5A25C768a4F99Af4;
    address public pdt = 0x08bBB4a9D79b8399852cE870a901577a939c9983;
    address public eth = 0x4200000000000000000000000000000000000006;
    address public sender = 0xECcEfbCE887DBdc1c393A409BaAb153F3380a364;
    address public pair = 0x486c627015838998A04e7742399700ff50643656;

    function swapUsdpToPdt() public {
      uint amountUsdpOut = 1e6;
      uint amountPdtInMin = 0;
      address[] memory paths = new address[](2);
      paths[0] = usdp;
      paths[1] = pdt;
      uint deadline = block.timestamp + 60;
      
      uint usdpBefore = IERC20(usdp).balanceOf(sender);
      uint pdtBefore = IERC20(pdt).balanceOf(sender);
      
      // trade 1 usdp for pdt
      // allowance
      IERC20(usdp).approve(router02, amountUsdpOut);
      
      (uint[] memory amountsReceived) = IUniswapV2Router02(router02).swapExactTokensForTokens(
        amountUsdpOut,
        amountPdtInMin,
        paths,
        sender,
        deadline	  
      );

      uint usdpAfter = IERC20(usdp).balanceOf(sender);
      uint pdtAfter = IERC20(pdt).balanceOf(sender);
      
      console.log("Swap 1 USDP for PDT");
      console.log("===========");
      console.log("USDP Before");
      console.logUint(usdpBefore);
      console.log("PDT Before");
      console.logUint(pdtBefore);
      console.log("===========");
      console.log("===========");
      console.log("USDP After");
      console.logUint(usdpAfter);
      console.log("PDT After");
      console.logUint(pdtAfter);
      console.log("===========");
      console.log("USDP Delta");
      console.logUint(usdpBefore - usdpAfter);
      console.log("PDT Delta");
      console.logUint(pdtAfter - pdtBefore);
      console.log("===========");
      
      for (uint i = 0; i < amountsReceived.length; i++) {
        console.logUint(amountsReceived[i]);
      }
       
      console.log("===========");
    }

    function swapPdtToUsdp() public {
      uint amountPdtOut = 1e18;
      uint amountUsdpInMin = 0;
      address[] memory paths = new address[](2);
      paths[0] = pdt;
      paths[1] = usdp;
      uint deadline = block.timestamp + 60;
      
      uint usdpBefore = IERC20(usdp).balanceOf(sender);
      uint pdtBefore = IERC20(pdt).balanceOf(sender);
      
      // trade 1 usdp for pdt
      // allowance
      IERC20(pdt).approve(router02, amountPdtOut);
      
      (uint[] memory amountsReceived) = IUniswapV2Router02(router02).swapExactTokensForTokens(
        amountPdtOut,
        amountUsdpInMin,
        paths,
        sender,
        deadline	  
      );

      uint usdpAfter = IERC20(usdp).balanceOf(sender);
      uint pdtAfter = IERC20(pdt).balanceOf(sender);
      
      console.log("Swap 1 PDT for USDP");
      console.log("===========");
      console.log("USDP Before");
      console.logUint(usdpBefore);
      console.log("PDT Before");
      console.logUint(pdtBefore);
      console.log("===========");
      console.log("===========");
      console.log("USDP After");
      console.logUint(usdpAfter);
      console.log("PDT After");
      console.logUint(pdtAfter);
      console.log("===========");
      console.log("USDP Delta");
      console.logUint(usdpAfter - usdpBefore);
      console.log("PDT Delta");
      console.logUint(pdtBefore - pdtAfter);
      console.log("===========");
      
      for (uint i = 0; i < amountsReceived.length; i++) {
        console.logUint(amountsReceived[i]);
      }
       
      console.log("===========");
    }

    function swapUsdpToPdtToWeth() public {
      uint amountUsdpIn = 1e6;
      uint amountWethExpectedMin = 0;
      address[] memory paths = new address[](3);
      paths[0] = usdp;
      paths[1] = pdt;
      paths[2] = eth;
      uint deadline = block.timestamp + 60;

      uint usdpBefore = IERC20(usdp).balanceOf(sender);
      uint pdtBefore = IERC20(pdt).balanceOf(sender);
      uint wethBefore = IERC20(eth).balanceOf(sender);

      IERC20(usdp).approve(router02, amountUsdpIn);

      (uint[] memory amountsReceived) = IUniswapV2Router02(router02).swapExactTokensForTokens(
        amountUsdpIn,
        amountWethExpectedMin,
	paths,
	sender,
	deadline
      );

      uint usdpAfter = IERC20(usdp).balanceOf(sender);
      uint pdtAfter = IERC20(pdt).balanceOf(sender);
      uint wethAfter = IERC20(eth).balanceOf(sender);

      console.log("Swap 1 USDP for PDT for WETH");
      console.log("===========");
      console.log("USDP Before");
      console.logUint(usdpBefore);
      console.log("WETH Before");
      console.logUint(wethBefore);
      console.log("PDT Before");
      console.logUint(pdtBefore);
      console.log("===========");
      console.log("===========");
      console.log("WETH After");
      console.logUint(wethAfter);
      console.log("USDP After");
      console.logUint(usdpAfter);
      console.log("PDT After");
      console.logUint(pdtAfter);
      console.log("===========");
      console.log("WETH Delta");
      console.logUint(wethAfter - wethBefore);
      console.log("USDP Delta");
      console.logUint(usdpBefore - usdpAfter);
      console.log("PDT Delta");
      console.logUint(pdtBefore - pdtAfter);
      console.log("===========");
      
      for (uint i = 0; i < amountsReceived.length; i++) {
        console.logUint(amountsReceived[i]);
      }
       
      console.log("===========");
    }

    function swapPdtToWeth() public {
      uint amountPdtOut = 10e18;
      uint amountWethInMin = 0;
      address[] memory paths = new address[](2);
      paths[0] = pdt;
      paths[1] = eth;
      uint deadline = block.timestamp + 60;
      
      uint wethBefore = IERC20(eth).balanceOf(sender);
      uint pdtBefore = IERC20(pdt).balanceOf(sender);
      
      // trade 1 pdt for weth
      // allowance
      IERC20(pdt).approve(router02, amountPdtOut);
      
      (uint[] memory amountsReceived) = IUniswapV2Router02(router02).swapExactTokensForTokens(
        amountPdtOut,
        amountWethInMin,
        paths,
        sender,
        deadline	  
      );

      uint wethAfter = IERC20(eth).balanceOf(sender);
      uint pdtAfter = IERC20(pdt).balanceOf(sender);
      
      console.log("Swap 1 PDT for WETH");
      console.log("===========");
      console.log("WETH Before");
      console.logUint(wethBefore);
      console.log("PDT Before");
      console.logUint(pdtBefore);
      console.log("===========");
      console.log("===========");
      console.log("WETH After");
      console.logUint(wethAfter);
      console.log("PDT After");
      console.logUint(pdtAfter);
      console.log("===========");
      console.log("WETH Delta");
      console.logUint(wethAfter - wethBefore);
      console.log("PDT Delta");
      console.logUint(pdtBefore - pdtAfter);
      console.log("===========");
      
      for (uint i = 0; i < amountsReceived.length; i++) {
        console.logUint(amountsReceived[i]);
      }
       
      console.log("===========");
    }

    function swapWethToPdt() public {
      uint amountWethOut = 1e12;
      uint amountPdtInMin = 0;
      address[] memory paths = new address[](2);
      paths[0] = eth;
      paths[1] = pdt;
      uint deadline = block.timestamp + 60;
      
      uint wethBefore = IERC20(eth).balanceOf(sender);
      uint pdtBefore = IERC20(pdt).balanceOf(sender);
      
      // trade 1 pdt for weth
      // allowance
      IERC20(eth).approve(router02, amountWethOut);
      
      (uint[] memory amountsReceived) = IUniswapV2Router02(router02).swapExactTokensForTokens(
        amountWethOut,
        amountPdtInMin,
        paths,
        sender,
        deadline	  
      );

      uint wethAfter = IERC20(eth).balanceOf(sender);
      uint pdtAfter = IERC20(pdt).balanceOf(sender);
      
      console.log("Swap 1e12 WETH for PDT");
      console.log("===========");
      console.log("WETH Before");
      console.logUint(wethBefore);
      console.log("PDT Before");
      console.logUint(pdtBefore);
      console.log("===========");
      console.log("===========");
      console.log("WETH After");
      console.logUint(wethAfter);
      console.log("PDT After");
      console.logUint(pdtAfter);
      console.log("===========");
      console.log("WETH Delta");
      console.logUint(wethBefore - wethAfter);
      console.log("PDT Delta");
      console.logUint(pdtAfter - pdtBefore);
      console.log("===========");
      
      for (uint i = 0; i < amountsReceived.length; i++) {
        console.logUint(amountsReceived[i]);
      }
       
      console.log("===========");
    }

    function swapPdtToEth() public {
      uint amountPdtOut = 1e18;
      uint amountEthInMin = 0;
      address[] memory paths = new address[](2);
      paths[0] = pdt;
      paths[1] = eth;
      uint deadline = block.timestamp + 60;
      
      uint pdtBefore = IERC20(pdt).balanceOf(sender);
      uint wethBefore = IERC20(eth).balanceOf(sender);
      uint ethBefore = address(sender).balance;
      
      // trade 1 pdt for eth
      // allowance
      IERC20(pdt).approve(router02, amountPdtOut);
      
      (uint[] memory amountsReceived) = IUniswapV2Router02(router02).swapExactTokensForETH(
        amountPdtOut,
        amountEthInMin,
        paths,
        sender,
        deadline	  
      );

      uint pdtAfter = IERC20(pdt).balanceOf(sender);
      uint wethAfter = IERC20(eth).balanceOf(sender);
      uint ethAfter = address(sender).balance;
      
      console.log("Swap 1 PDT for ETH");
      console.log("===========");
      console.log("PDT Before");
      console.logUint(pdtBefore);
      console.log("WETH Before");
      console.logUint(wethBefore);
      console.log("ETH Before");
      console.logUint(ethBefore);
      console.log("===========");
      console.log("===========");
      console.log("PDT After");
      console.logUint(pdtAfter);
      console.log("WETH After");
      console.logUint(wethAfter);
      console.log("ETH After");
      console.logUint(ethAfter);
      console.log("===========");
      console.log("PDT Delta");
      console.logUint(pdtBefore - pdtAfter);
      console.log("ETH Delta");
      console.logUint(ethAfter - ethBefore);
      console.log("WETH Delta");
      console.logUint(wethAfter - wethBefore);
      console.log("===========");
      
      for (uint i = 0; i < amountsReceived.length; i++) {
        console.logUint(amountsReceived[i]);
      }
       
      console.log("===========");
    }

    function swapEthToPdt() public {
      uint amountEthIn = 1e14;
      uint amountPdtOutMin = 0;
      address[] memory paths = new address[](2);
      paths[0] = eth;
      paths[1] = pdt;
      uint deadline = block.timestamp + 60;
      
      uint pdtBefore = IERC20(pdt).balanceOf(sender);
      uint wethBefore = IERC20(eth).balanceOf(sender);
      uint ethBefore = address(sender).balance;
      
      // trade 1 eth for eth
      // allowance
      // IERC20(pdt).approve(router02, amountPdtOut);
      
      (uint[] memory amountsReceived) = IUniswapV2Router02(router02).swapExactETHForTokens{value: amountEthIn}(
        amountPdtOutMin,
        paths,
        sender,
        deadline	  
      );

      uint pdtAfter = IERC20(pdt).balanceOf(sender);
      uint wethAfter = IERC20(eth).balanceOf(sender);
      uint ethAfter = address(sender).balance;
      
      console.log("Swap 1 ETH for PDT");
      console.log("===========");
      console.log("PDT Before");
      console.logUint(pdtBefore);
      console.log("WETH Before");
      console.logUint(wethBefore);
      console.log("ETH Before");
      console.logUint(ethBefore);
      console.log("===========");
      console.log("===========");
      console.log("PDT After");
      console.logUint(pdtAfter);
      console.log("WETH After");
      console.logUint(wethAfter);
      console.log("ETH After");
      console.logUint(ethAfter);
      console.log("===========");
      console.log("PDT Delta");
      console.logUint(pdtAfter - pdtBefore);
      console.log("ETH Delta");
      console.logUint(ethBefore - ethAfter);
      console.log("WETH Delta");
      console.logUint(wethBefore - wethAfter);
      console.log("===========");
      
      for (uint i = 0; i < amountsReceived.length; i++) {
        console.logUint(amountsReceived[i]);
      }
       
      console.log("===========");
    }

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

	swapUsdpToPdt();
	swapPdtToUsdp();
	swapPdtToEth();
	swapEthToPdt();
	swapPdtToWeth();
	swapWethToPdt();
	swapUsdpToPdtToWeth();

        vm.stopBroadcast();
    }
}
