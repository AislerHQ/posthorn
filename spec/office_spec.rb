require 'spec_helper'

describe Office do
  it 'should receive all page formats' do
    office = Office.new
    formats = office.page_formats

    expect(formats).to be_an Array
    expect(formats.length).to eq(108)
    expect(formats[0].id).to eq('7')
    expect(formats[0].name).to eq('Herma 8748 CompactLine 105 x 74')
  end

  it 'should return user\'s wallet balance' do
    office = Office.new
    expect(office.user.wallet_balance).to be_an Fixnum
    expect(office.user.wallet_balance).to be > 0
  end

  describe 'checkout!' do
    let(:office) { Office.new }
    let(:receiver) do
      Address.new(
        company: 'Hans Peter Wurst Inc.',
        firstname: 'Hans Peter',
        lastname: 'Wurst',
        street: 'Schoolstraat',
        no: '2',
        city: 'Lemiers',
        zip: '6295',
        country: 'de'
      )
    end
    let(:sender) do
      Address.new(
        company: 'AISLER B.V.',
        street: 'Schoolstraat',
        no: '2',
        city: 'Lemiers',
        zip: '6295AV',
        country: 'nl'
      )
    end

    before do
      office.cart << Label.new(sender, receiver, product_id: 21, price: 145)
    end

    context 'when downloading labels' do
      let(:response) { office.checkout!(page_format: 25) }

      it 'has one item in the cart' do
        expect(office.cart.length).to eq(1)
      end

      it 'should order national post stamps' do
        expect(response.length).to be >= 100
      end
    end

    context 'when not downloading labels' do
      let(:response) { office.checkout!(page_format: 25, download_labels: false) }

      it 'returns the response of the API' do
        expect(response[:link]).to be_a(String)
      end
    end
  end

  it 'should return cart\' balance' do
    office = Office.new

    receiver = Address.new(
      company: 'Hans Peter Wurst Inc.',
      firstname: 'Hans Peter',
      lastname: 'Wurst',
      street: 'Schoolstraat',
      no: '2',
      city: 'Lemiers',
      zip: '6295',
      country: 'de')

    sender = Address.new(
      company: 'AISLER B.V.',
      street: 'Schoolstraat',
      no: '2',
      city: 'Lemiers',
      zip: '6295AV',
      country: 'nl')

    office.cart << Label.new(sender, receiver, product_id: 21, price: 145)
    office.cart << Label.new(sender, receiver, product_id: 21, price: 145)
    office.cart << Label.new(sender, receiver, product_id: 21, price: 145)

    expect(office.balance).to eq(3 * 145)
  end
end
