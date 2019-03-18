var Casino = artifacts.require("./SmartContract1.sol");

module.exports = function(deployer) {
	deployer.deploy(Casino, {gas: '3000000'});
}