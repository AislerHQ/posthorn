require 'posthorn'
include Posthorn

Posthorn.configure do |c|
  c.dpwn_key = ENV['POSTHORN_DPWN_KEY']
  c.partner_id = ENV['POSTHORN_PARTNER_ID']
  c.key_phase = ENV['POSTHORN_KEY_PHASE']
  c.username = ENV['POSTHORN_USERNAME']
  c.password = ENV['POSTHORN_PASSWORD']
end