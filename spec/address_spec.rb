require 'spec_helper'

describe Address do
  it 'should create company and private addresses', focus: true do
    address = Address.new(firstname: 'Hans Peter',
      lastname: 'Wurst',
      street: 'Schoolstraat',
      no: '2',
      city: 'Lemiers',
      zip: '6295AV',
      country: 'nl'
      )

    expect(address.company?).to be_falsey
    expect(address.to_h[:name][:companyName]).to be_nil
    expect(address.to_h[:name][:personName]).not_to be_nil


    address = Address.new(company: 'Wurst & Co.',
      firstname: 'Hans Peter',
      lastname: 'Wurst',
      street: 'Schoolstraat',
      no: '2',
      city: 'Lemiers',
      zip: '6295AV',
      country: 'nl'
      )

    expect(address.company?).to be_truthy
    expect(address.to_h[:name][:companyName]).not_to be_nil
    expect(address.to_h[:name][:personName]).to be_nil

    address = Address.new(company: 'Hans Peter Wurst',
      firstname: 'Hans Peter',
      lastname: 'Wurst',
      street: 'Schoolstraat',
      no: '2',
      city: 'Lemiers',
      zip: '6295AV',
      country: 'nl'
      )

    expect(address.company?).to be_falsey
    expect(address.to_h[:name][:companyName]).to be_nil
    expect(address.to_h[:name][:personName]).not_to be_nil
  end

  it 'should create addresses with street and number combined' do
    address = Address.new(company: 'Wurst & Co.',
      firstname: 'Hans Peter',
      lastname: 'Wurst',
      street: 'Schoolstraat 2',
      city: 'Lemiers',
      zip: '6295AV',
      country: 'nl'
      )

      expect(address.street).to eq('Schoolstraat 2')
  end

end