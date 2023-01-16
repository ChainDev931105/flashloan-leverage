import { artifacts, ethers } from "hardhat";

export async function deployMockToken(name: string, symbol: string, decimals: number) {
  const mockTokenFactory = await ethers.getContractFactory("MockToken");
  const mockToken = await mockTokenFactory.deploy(name, symbol, decimals);
  await mockToken.deployed();
  return mockToken;
}

export async function deployMockAAVEProvider() {
  return { address: "" };
}

export async function deployMockUniswapV3Pool() {
  return { address: "" };
}

export async function deployMockWETH() {
  const mockWETHFactory = await ethers.getContractFactory("MockWETH");
  const mockWETH = await mockWETHFactory.deploy();
  await mockWETH.deployed();
  return mockWETH;
}
