pragma solidity ^0.6.6;

import "v2-periphery/libraries/UniswapV2Library.sol";
import "v2-core/interfaces/IUniswapV2Pair.sol";

import "./interfaces/ILiquidityValueCalculator.sol";

contract LiquidityValueCalculator is ILiquidityValueCalculator {
  address public factory;
  
  constructor(address factory_) public {
    factory = factory_;
  }

  function pairInfo(address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB, uint totalSupply) {
    IUniswapV2Pair pair = IUniswapV2Pair(UniswapV2Library.pairFor(factory, tokenA, tokenB));
    totalSupply = pair.totalSupply();
    (uint reserves0, uint reserves1, ) = pair.getReserves();
    (reserveA, reserveB) = tokenA == pair.token0() ? (reserves0, reserves1) : (reserves1, reserves0);
  }

  function computeLiquidityShareValue(uint liquidity, address tokenA, address tokenB) external override returns (uint tokenAAmount, uint tokenBAmount) {
    (uint reserveA, uint reserveB, uint totalSupply) = pairInfo(tokenA, tokenB);
    tokenAAmount = reserveA * liquidity / totalSupply;
    tokenBAmount = reserveB * liquidity / totalSupply;
  }
}
