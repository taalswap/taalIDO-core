const { expect } = require('chai');
const TAL = artifacts.require('TaalswapToken');

let instance;

contract('TaalswapToken', accounts => {
    beforeEach(async function () {
        instance = await TAL.deployed();
    });

    it('Pause Taalswap Token', async function () {
        await instance.pause();
        expect(await instance.paused()).to.equal(true);
    });

    it('Unpause Taalswap Token', async function () {
        await instance.unpause();
        expect(await instance.paused()).to.equal(false);
    });
});
