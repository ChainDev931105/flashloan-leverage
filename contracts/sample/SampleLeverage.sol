// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

contract SampleLeverage is Ownable, FlashLoanSimpleReceiverBase {
    IERC20 token;
    IUniswapV3Pool uniswapV3Pool;

    constructor(
        address _token,
        address _uniswapV3Pool,
        address _aaveProvider,
        address _user
    ) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_aaveProvider)) {
        token = IERC20(_token);
        uniswapV3Pool = IUniswapV3Pool(_uniswapV3Pool);
        transferOwnership(_user);
    }

    function leverage(uint256 loanAmount) public payable onlyOwner {
        // step 1. User deposit ETH to Leverage
        uint256 ethAmount = msg.value;

        // step 2. loan token from flashloanProvider
        POOL.flashLoanSimple(address(this), address(token), loanAmount, "", 0);
    }

    function deleverage() public onlyOwner {}

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address, // initiator
        bytes memory // params
    ) public override returns (bool) {
        // step 3. swap from token to eth on exchange
        (int256 amount0, int256 amount1) = uniswapV3Pool.swap(address(this), false, int256(amount), 0, "");
        uint256 swappedEthAmount = uint256(amount0);
        uint256 ethAmount = 0; // TODO:

        // step 4. deposit entire eth to lendingPool
        // POOL.deposit(
        //     asset,
        //     amount,
        //     onBehalfOf,
        //     referralCode
        // );

        uint256 paybackAmount = amount + premium;

        // step 5. borrow token from lendingPool
        POOL.borrow(address(token), paybackAmount, 1, 0, address(this));

        // step 6. payback token to flashloanProvider
        token.approve(address(POOL), paybackAmount);
    }
}
