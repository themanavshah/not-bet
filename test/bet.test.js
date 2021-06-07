const { should } = require('chai');
var Web3 = require('web3');
var web3 = new Web3(Web3.givenProvider || 'ws://some.local-or-remote.node:8546');
const BigNumber = web3.bignumber;

require("chai")
    .use(require('chai-bignumber')(BigNumber))
    .use(require('chai-as-promised'))
    .should();

const Bet = artifacts.require('Bet');

contract('Bet', function ([_, wallet]) {

    const _name = 'notBet';

    beforeEach(async function () {
        this.betContract = await Bet.new(_name);
    })

    describe('bet init', function () {
        it('has the correct name', async function () {
            const name = await this.betContract.nameContract();
            name.should.equal(_name);
        });

        it('return 1', function () {
            ///console.log("bet returns: ", this.betContract);
        })
    });
})