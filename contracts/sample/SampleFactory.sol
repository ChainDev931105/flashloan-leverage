// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import { Factory } from "../Factory.sol";
import { SampleLeverage } from "./SampleLeverage.sol";

contract SampleFactory is Factory {
    address private immutable token;
    address private immutable aaveProvider;
    address private immutable uniswapV3Pool;
    address private immutable aaveWETH;

    constructor(address _token, address _aaveProvider, address _uniswapV3Pool, address _aaveWETH) {
        token = _token;
        aaveProvider = _aaveProvider;
        uniswapV3Pool = _uniswapV3Pool;
        aaveWETH = _aaveWETH;
    }

    function createLeverage() external override {
        SampleLeverage leverage = new SampleLeverage(token, msg.sender, aaveProvider, uniswapV3Pool, aaveWETH);
        emit LeverageCreated(msg.sender, address(leverage));
    }
}
