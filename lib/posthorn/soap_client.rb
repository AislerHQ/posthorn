module Posthorn
  class SoapClient

    def initialize
      header = {
        partner_id: Posthorn.configuration.partner_id,
        request_timestamp: Time.now.strftime('%d%m%Y-%H%M%S'),
        key_phase: 1
      }
      header[:partner_signature] = Digest::MD5.hexdigest(header.values.push(Posthorn.configuration.dpwn_key).join('::'))[0..7]


      @base = Savon.client({
        wsdl: 'https://internetmarke.deutschepost.de/OneClickForAppV3/OneClickForAppServiceV3?wsdl',
        convert_request_keys_to: :none,
        soap_header: header
      })
    end

    def authenticate
      response = @base.call(:authenticate_user, message: { username: Posthorn.configuration.username, password: Posthorn.configuration.password })
      user = OpenStruct.new response.body[:authenticate_user_response]
      user.wallet_balance = user.wallet_balance.to_i

      user
    end

    def call(method, message = {})
      @base.call(method, message: message)
    end
  end
end