module Posthorn
  class Address
    attr_accessor :company, :firstname, :lastname, :street, :no, :zip, :city, :country

    def initialize(data)
      @company = data[:company]
      @lastname = data[:lastname]
      @firstname = data[:firstname]


      @no = data[:no] || ''
      @street = data[:street]
      @city = data[:city]
      @zip = data[:zip]
      @country = data[:country].is_a?(String) ? ISO3166::Country.new(data[:country]) : data[:country]
    end

    def company?
      @company && !@company.blank? && (@company != [@firstname, @lastname].join(' '))
    end

    def to_h
      rtn = {
        name: {}
      }

      if company?
        rtn[:name][:companyName] = { company: @company }
        if @firstname && @lastname
          rtn[:name][:companyName][:personName] = {
              firstname: @firstname,
              lastname: @lastname
            }
        end
      else
        rtn[:name][:personName] = {
            firstname: @firstname,
            lastname: @lastname
          }
      end
      rtn[:address] = {
          street: @street,
          houseNo: @no,
          zip: @zip,
          city: @city,
          country: @country.alpha3
        }

      rtn
    end
  end
end