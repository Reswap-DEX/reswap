const Migrations = artifacts.require('./Migrations.sol');
const ReswapFactory = artifacts.require('./ReswapFactory.sol');
const ReswapHelper = artifacts.require('./ReswapHelper.sol');

// const Reswap = artifacts.require('./Reswap.sol');

module.exports = function (deployer) {
    deployer.deploy(Migrations);
    deployer.deploy(ReswapFactory);
    deployer.deploy(ReswapHelper);

    // deployer.deploy(Reswap);
};
