module Posthorn
  class Office
    attr_reader :user
    attr_accessor :cart

    def initialize
      @client = SoapClient.new
      @user = @client.authenticate
      @cart = []
    end

    def page_formats
      response = @client.call(:retrieve_page_formats)
      response.body[:retrieve_page_formats_response][:page_format].map do |fmt|
        OpenStruct.new fmt
      end
    end

    def balance
      cents = 0
      @cart.each { |label| cents += label.price }
      cents
    end

    def checkout!(args = {})
      page = 0

      message = {
        userToken: @user.user_token,
        pageFormatId: args[:page_format] || 25, # Brother 62mm
        positions: @cart.map.with_index { |label, ix| label.to_h(page: ix) },
        total: balance
      }

      response = @client.call(:checkout_shopping_cart_pdf, message)
      data = response.body[:checkout_shopping_cart_pdf_response]
      @user.wallet_balance = data[:wallet_ballance]

      @cart.clear


      request = HTTPI::Request.new
      request.url = data[:link]
      request.read_timeout = 240
      HTTPI.get(request).body
    end
  end
end