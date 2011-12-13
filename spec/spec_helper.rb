require 'rubygems'
require 'activemerchant-bpoint'
require 'support/gateway_helpers'
require 'vcr'

RSpec.configure do |config|
  config.include GatewayHelpers
end

VCR.config do |c|
  c.cassette_library_dir = File.dirname(__FILE__) + '/support/vcr_cassettes'
  c.stub_with :fakeweb
end
