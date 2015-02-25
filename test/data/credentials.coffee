fs = require "fs"
yaml = require "js-yaml"
cp = require 'child_process'
string = fs.readFileSync "./test/data/wallet.yaml"
data = yaml.safeLoad(string)

email = () -> "js-test-#{Date.now()}@mail.com"

pubkey = """-----BEGIN PUBLIC KEY-----
  MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwJyfSUKm9Xd48yfImxDX
  DoBqh7O6PacgDfmXBEztFFA3A4ReoEGxtNj+9PWnrWwgcWeGEL62d9UWdTbVtUrh
  skXrWMtnt+HUzwEwdN0At3V0e3XdGwtndl9TJ94L7smltmSDHIxRl25Dj7sgmwmo
  Ht59UDik/Y8a/8/Fr500VF6mNV8+1fsy3rLp/is840Uomd++V3iuFCjzVIsJPo1y
  JlY/qSrPr4z2y/sH8GbiiuI3vDM+OW3RFDReBx6c0m/3x7UaBW7++lWveuIWB4aT
  HY+dXai8khSDDFobckR6EjfrCvIJlFAdi+frMZx7g31gxMaCXMbERDjQUS8vWvdG
  rQIDAQAB
  -----END PUBLIC KEY-----
  """

privkey = """-----BEGIN RSA PRIVATE KEY-----
  MIIEowIBAAKCAQEAwJyfSUKm9Xd48yfImxDXDoBqh7O6PacgDfmXBEztFFA3A4Re
  oEGxtNj+9PWnrWwgcWeGEL62d9UWdTbVtUrhskXrWMtnt+HUzwEwdN0At3V0e3Xd
  Gwtndl9TJ94L7smltmSDHIxRl25Dj7sgmwmoHt59UDik/Y8a/8/Fr500VF6mNV8+
  1fsy3rLp/is840Uomd++V3iuFCjzVIsJPo1yJlY/qSrPr4z2y/sH8GbiiuI3vDM+
  OW3RFDReBx6c0m/3x7UaBW7++lWveuIWB4aTHY+dXai8khSDDFobckR6EjfrCvIJ
  lFAdi+frMZx7g31gxMaCXMbERDjQUS8vWvdGrQIDAQABAoIBAQCGgVliyZ7aMBJQ
  i2m1j+7+e4LpPQND5p+l4rQpFqdA1jt0w01pUDcO+bIh0iLEIowNZaPjsaquyCmk
  tSRMM/ykh9sv6OuHJ7d6z3PNSEAl3Wn4hXhgWHhp22uwnYlruXl1g39jwkGAJEod
  5yl/2yCCXhDYopXlU7ghCDEe0AMpHrGBtlVoAOgNyocv5BIIsMR3W9o7JyZO9WWh
  XgZhb5NP6oLRxx+iW5qz3iN+8l1AHfEkCGKt1LxUh2yv5iO1u2N747iwPQ53zMSj
  +rxZVYI4wnsIkvwEFz7d9vvO1fw2GRlL/oU3idbOr9nHw46xNNt+s7ihrnXDHXRg
  jXOJDLIBAoGBAN+loj22wzMgezNMj0CN/KN8KBfGXzfDtKl2PCYbavDT8iesbHU+
  uMIXlV4vzFIob2mIh7PXKMiU8l/8rEk4BvOj9L1qVTn7AMugxXo0SnBB7/QLeW45
  ddeRGN6z3sUv+EIGSu9Eq+JYCoc8CyMX7gR54flLXL0DqRyB9c/4ZspBAoGBANx5
  p8aWfxggpt2Z3NyLrs+C3x80myBiOK3YbPAYX3A92h22rXPWwtZR6+GX8ETmnsl9
  +qRtQke7adt0DO06frZ7LHvz+W8kEzqjpOFA3yZB4h2KWzlonFOKy33jfuUFv/5f
  Gnt2L+z6TV+H/c3cUdwZZ3+KLOo8DqXkcoz1nultAoGADOVdJJfcS59s2zln7T4C
  ul6XZT+QEAQd78OclknwcbCW/winPF+AgdigSU0SSA6C1iAESy9175L/It/MA3DS
  ncvvediez3gUxKkhmflX7X8v2e+rcdqoW+TG/Vh72Pz6ILyCJ6fbDXMsMD4bGkvv
  8pwglqJs141VfApWZUaajsECgYAPpz+HNPYvE1plj2AD9JLjvsnyoDyHTxHxHdWW
  MlTMVkffJjIocE4DA2v4512ytqD9c0lRVUSIbUD1yMaGLUoD0Lj2z/qcrnYDCs1R
  BNcTE0hnioQxjkDTGZ6bAITo48Ce4ceyjlCWxaqqprAZZpQVSWR0xK2tr7fmhVKw
  uVuf/QKBgHAp200rLep+QptWoPaWetvwiQkRoIZrHrTS2McBb2LVyCxp0+oGWOk5
  cY8ZVD2l4RqnCto6mgAsXxkVlbbM3u0vg2Cvfz97WuI/cYPofGD8K2IY4E4k1zWd
  nDx0pX2tKDrix8yGKr/EttgjRKyymTIngxSZb9vLTX9aEOubIxCp
  -----END RSA PRIVATE KEY-----
  """
  
# NOTE: ALL PROPERTIES NEED TO BE RESET WHEN DB IS RESET
# NOTE: USER_TOKEN AND USER_URL NEED BE TAKEN FROM A
# NEW USER, WITH EMAIL: 'bez@gem.co'
# These value will be printed in the 2nd part of client.authenticateDevice test
authenticateDeviceCreds = (applications) -> {
  api_token: applications.get('default').api_token,
  app_url: applications.get('default').url,
  key: 'otp.sJiihGPdK9hS2jElPm-FbQ',
  secret: '79p3Dds5O09itmZM60XHPw',
  device_id: 'newdeviceid1424820618380',
  user_token: 'KpMJUyGfpf4z463fXetX9QoWFBvQ6uQmdlmGOEOS8Ok',
  # user_url: 'http://localhost:8999/users/RpwPD84-a6_XQHqduWKZlw',
  name: 'newDevice'
  email: 'bez@gem.co'
}


genKeys = (cb) ->
  # gen private
  cp.exec 'openssl genrsa 2048', (err, priv, stderr) ->
    # tmp file
    randomfn = './' + Math.random().toString(36).substring(7)
    fs.writeFileSync randomfn, priv
    # gen public
    cp.exec 'openssl rsa -in ' + randomfn + ' -pubout', (err, pub, stderr) ->
      # delete tmp file
      fs.unlinkSync randomfn
      # callback
      cb {
        pub: pub
        priv: priv
      }



module.exports = {
  pubkey: pubkey

  privkey: privkey
  
  newDevCreds: (cb) ->
    genKeys (keys) ->
      {pub, priv} = keys
      cb {email: email(), pubkey: pub, privkey: priv }

  newUserContent: -> {email: "js-test-#{Date.now()}@mail.com", wallet: data.wallet }

  # NOTE: EMAIL MUST BE RESET WHEN DATABASE RESETS
  existingDevCreds: {email: 'bez@gem.co', pubkey, privkey }

  authenticateDeviceCreds: authenticateDeviceCreds

}


