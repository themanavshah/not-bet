const Bet = artifacts.require('./Bet.sol');

module.exports = function (deployer) {
    const _name = 'notBet'
    deployer.deploy(Bet, _name);
}