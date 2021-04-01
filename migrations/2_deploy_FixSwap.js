const FixedSwap = artifacts.require('FixedSwap');

module.exports = async function (deployer) {
    // deployer.deploy(TAL, '0x71d53E5175Da8A2f032F10b33700457488ee02f4');
    deployer.deploy(FixedSwap);
};
