module Posthorn
  def self.configuration
    @config ||= Configuration.new
  end

  def self.configuration=(c)
    @config = c
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :dpwn_key, :partner_id, :key_phase, :username, :password

    def initialize
      # Set default values here
      @key_phase = 1
    end
  end
end