const { mnemonic } = require('./secrets.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
    compilers: {
        solc: {
            version: '0.6.12',
            settings: {
                optimizer: {
                    enabled: true,
                    runs: 1000000,
                }
            }
        },
    },
    plugins: ["solidity-coverage"],
    mocha: { // https://github.com/cgewecke/eth-gas-reporter
        reporter: 'eth-gas-reporter',
        reporterOptions : {
            currency: 'USD',
            gasPrice: 10,
            onlyCalledMethods: true,
            showTimeSpent: true,
            excludeContracts: ['Migrations', 'mocks']
        }
    },
    networks: {
        development: {
          provider: () => new HDWalletProvider(mnemonic, "https://data-seed-prebsc-1-s1.binance.org:8545"),
          network_id: 97, // match any network
          websockets: false
        },
        live: {
          host: "bsc-dataseed.binance.org", // Random IP for example purposes (do not use)
          port: 80,
          network_id: 56,        // Ethereum public network
          // optional config values:
          // gas
          // gasPrice
          // from - default address to use for any transaction Truffle makes during migrations
          // provider - web3 provider instance Truffle should use to talk to the Ethereum network.
          //          - function that returns a web3 provider instance (see below.)
          //          - if specified, host and port are ignored.
          // skipDryRun: - true if you don't want to test run the migration locally before the actual migration (default is false)
          // timeoutBlocks: - if a transaction is not mined, keep waiting for this number of blocks (default is 50)
        }
      }
};
