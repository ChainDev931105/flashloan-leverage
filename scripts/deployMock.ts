import { ethers } from "hardhat";
import * as fs from "fs";

import {
  deploySimpleFactory,
  createSimpleLeverage,
  deployMockToken,
  deployMockAAVEProvider,
  deployMockUniswapV3Pool,
  deployMockWETH,
} from "../instructions";
import { ADDRESS_PATH } from "./utils";

const ADDRESSES = require("../" + ADDRESS_PATH);

async function main() {
  const usdc = await deployMockToken("USDC", "USDC", 18);
  ADDRESSES.USDC = usdc.address;

  const aaveProvider = await deployMockAAVEProvider();
  ADDRESSES.AAVEProvider = aaveProvider.address;

  const uniswapV3Pool = await deployMockUniswapV3Pool();
  ADDRESSES.AAVEProvider = aaveProvider.address;

  const mockWETH = await deployMockWETH();
  ADDRESSES.MockWETH = mockWETH.address;

  const simpleFactory = await deploySimpleFactory(
    usdc.address,
    aaveProvider.address,
    uniswapV3Pool.address,
    mockWETH.address,
  );
  ADDRESSES.Factory = simpleFactory.address;

  fs.writeFileSync(ADDRESS_PATH, JSON.stringify(ADDRESSES, null, 4), "utf8");
}

main().catch(error => {
  console.error(error);
  process.exitCode = 1;
});
