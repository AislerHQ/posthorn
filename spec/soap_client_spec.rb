require 'spec_helper'

describe SoapClient do
  it 'should authenticate user and get an user token' do
    client = SoapClient.new
    user = client.authenticate
    expect(user.user_token.length).to be(44)
    expect(user.wallet_balance).to be_an Fixnum
  end
end