// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IUniswapV3Pool } from "../interfaces/IUniswapV3Pool.sol";
import { IWETH } from "../interfaces/IWETH.sol";
import { SwapAdapter } from "../abstracts/SwapAdapter.sol";

/*
    token0 is WETH
    token1 is token
*/
contract UniswapSwap is SwapAdapter {
    IUniswapV3Pool immutable uniswapV3Pool;
    IWETH private immutable weth;
    IERC20 private immutable token;

    constructor(address _uniswapV3Pool) {
        uniswapV3Pool = IUniswapV3Pool(_uniswapV3Pool);
        weth = IWETH(uniswapV3Pool.token0());
        token = IERC20(uniswapV3Pool.token1());
    }

    /*
        mode 0: from eth to token with eth amount
        mode 1: from eth to token with token amount
        mode 2: from token to eth with token amount
        mode 3: from token to eth with eth amount
    */
    function _swap(uint256 amount, uint16 mode) internal override returns (int256 amount0, int256 amount1) {
        require(mode >= 0 && mode < 4, "Unknown mode");
        bool zeroForOne;
        int256 amountSpecified = (mode & 1 == 0) ? int256(amount) : -int256(amount);

        if (mode & 2 == 0) {
            // from eth to token
            weth.deposit{ value: amount }();
            zeroForOne = true;
        } else {
            // from token to eth
            token.approve(address(uniswapV3Pool), amount);
            zeroForOne = false;
        }

        uniswapV3Pool.swap(address(this), zeroForOne, amountSpecified, 0, "");
        if (mode & 2 == 2) {
            weth.withdraw(amount);
        }
        emit Swapped(amount, mode, amount0, amount1);
    }
}
