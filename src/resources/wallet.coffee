
Accounts = require('./accounts')
Base = require('./base')
CoinOp = require 'coinop-node'
PassphraseBox = CoinOp.crypto.PassphraseBox
MultiWallet = CoinOp.bit.MultiWallet

module.exports = class Wallet extends Base

  constructor: ({resource, client, multiwallet, application}) ->
    @client = client
    @resource = resource
    # if @ is a newly created wallet, then it has access to the master node
    # via the passed multiwallet. However, if this wallet object is being pulled
    # down from the api it needs to be unlocked. @unlock will reset @multiwallet
    @multiwallet = multiwallet
    @application = application
    {@name, @cosigner_public_seed, @backup_public_seed,
    @primary_public_seed, @balance, @default_account, @transactions} = resource


  accounts: ->
    @getAssociatedCollection({
      collectionClass: Accounts,
      name: 'accounts',
      options: {
        wallet: @
      }
    })


  unlock: ({passphrase}) ->
    primary_seed = PassphraseBox.decrypt(passphrase, @resource.primary_private_seed)
    @multiwallet = new MultiWallet({
      private: {
        primary: primary_seed
      },
      public: {
        cosigner: @resource.cosigner_public_seed,
        backup: @resource.backup_public_seed
      }
    })
    return @


  backup_key: ->
    @multiwallet.trees.backup.seed.toString('hex')
