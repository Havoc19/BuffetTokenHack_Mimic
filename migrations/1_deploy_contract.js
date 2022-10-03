const HackedContract = artifacts.require("BEP20Token")
const FakeLp = artifacts.require("FakeLp")
const HackerContract = artifacts.require("HackerContract")

module.exports = async function (deployer) {
    await deployer.deploy(HackedContract);
    const hackedContract = await HackedContract.deployed()

    await deployer.deploy(FakeLp, hackedContract.address)
    const fakeLp = await FakeLp.deployed()

    await deployer.deploy(HackerContract, hackedContract.address, fakeLp.address)
    
};
  