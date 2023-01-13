// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

abstract contract SwapAdapter {
    event Swapped(uint256 amount, uint16 mode, int256 amount0, int256 amount1);
    function _swap(uint256 amount, uint16 mode) internal virtual returns (int256, int256);
}
