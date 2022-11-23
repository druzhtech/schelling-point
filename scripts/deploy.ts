import { ethers } from "hardhat";

async function main() {
  const St = await ethers.getContractFactory("SchellingToken");
  const st = await St.deploy();

  await st.deployed();

  console.log(`SchellingToken deployed to ${st.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
