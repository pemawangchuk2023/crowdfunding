// CrowdFunding deployed to: 0x027aF9673302ca41CF519cAF9CAbCfFfb1E6b041
const hre = require('hardhat');

async function main() {
  const CrowdFunding = await hre.ethers.getContractFactory('CrowdFunding');
  const crowdFunding = await CrowdFunding.deploy();

  await crowdFunding.deployed();

  console.log('CrowdFunding deployed to:', crowdFunding.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
