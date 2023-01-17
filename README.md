# Flashloan Leverage

Due to USDC address on Goerli is different in Uniswap and AAVE, I've decided to test with Mock contracts.
Currently, smart contract and minimal test code is done. I will deploy and test them on Goerli later.

## Scripts

### Test
```
yarn test
```

### Deploy (Mock version on Goerli testnet)
```
yarn deploy:mock
```

## Contracts
```
Factory: 
contracts/v-simple/SimpleFactory.sol
Leverage: 
contracts/v-simple/SimpleLeverage.sol
```

## Deployments (Goerli testnet)

|Contract|Address|
|---|---|
|Factory |0xBc26FE49b6C19eE7D15BD1C33406201C5F659a23|
|Leverage |0xedEB0500Ab4CaD27749Acf7244eDCfaee4E55410|
|USDC |0xA058224aFCFE2875896c77c5304Df151b97544c8|
|MockWETH (For AAVE) |0x89E6098F06371F505983669a20f70903C50Ccdb5|
|MockWETH (For Uniswap) |0x4223FCAdf62052f469fc3A88d5E7e1bA846551Ab|
|MockAAVEPool |0x4859da93158511fB8A645C9a4a8D932e14F0FD73|
|AaveProvider |0xA3Dbf03F6662747a7cd6D051fe2c614acEa7C90d|
|MockUniswapV3Pool |0x26fD03E9cC04162837Bc120608636436802b871D|
