const MonContrat = artifacts.require("MonContrat");

module.exports = function(deployer) {
  deployer.deploy(MonContrat);
};