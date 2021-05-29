const DeedMultiPayout = artifacts.require("DeedMultiPayout");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(DeedMultiPayout, accounts[0], accounts[1],10, {value:100});
};
