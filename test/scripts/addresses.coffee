Round = require '../../src'
Address = require '../../src/resources/address'

expect = require('chai').expect
fs = require "fs"
yaml = require "js-yaml"
string = fs.readFileSync "./test/data/wallet.yaml"
data = yaml.safeLoad(string)
credentials = require '../data/credentials'
{pubkey, privkey, newDevCreds, newUserContent, existingDevCreds, authenticateDeviceCreds} = credentials


describe 'Addresses Resource', ->
  client = developer = user = applications = accounts = account = wallet = ''

  before (done) ->
    Round.client 'http://localhost:8999','testnet3', (error, cli) ->
      cli.authenticateDeveloper existingDevCreds, (error, dev) ->
        dev.applications (error, apps) ->
          client = cli; developer = dev; applications = apps;

          client.authenticateDevice authenticateDeviceCreds(applications), (error, usr) ->
            user = usr
            user.wallets (error, wallets) ->
              wallet = wallets.collection.default
              wallet.accounts (error, accnts) ->
                accounts = accnts
                account = accounts.collection.default
                done(error)


  # skipping because it creates everytime
  describe.skip 'addresses.create', ->
    addresses = address =''

    before (done) ->
      account.addresses (error, addrs) ->
        addrs.create (error, addr) ->
          addresses = addrs; address = addr
          done(error)

    it 'should create an addresses object', ->
      expect(address).to.be.an.instanceof(Address)

    it 'should add the new address to the collection', ->
      expect(addresses.collection).to.have.a.property(address.resource().string)