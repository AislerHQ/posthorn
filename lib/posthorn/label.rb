module Posthorn
  class Label
    attr_accessor :sender, :receiver, :product_id, :price

    def initialize(sender, receiver, args = {})
      @sender = sender
      @receiver = receiver
      @product_id = args[:product_id] || 11 # Kompaktbrief
      @price = args[:price] || 0
    end

    def to_h(args = {})
      rtn = {
        productCode: @product_id,
        address: {
          sender: @sender.to_h,
          receiver: @receiver.to_h
        },
        voucherLayout: 'AddressZone',
        position: {
          labelX: 1,
          labelY: 1,
          page: (args[:page] || 0) + 1
        }
      }

      rtn
    end
  end
end