require 'rubygems'
require 'activemerchant-bpoint'
require 'support/gateway_helpers'
require 'vcr'
require 'test_credentials'

RSpec.configure do |config|
  config.include GatewayHelpers
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

VCR.configure do |c|
  c.cassette_library_dir = File.dirname(__FILE__) + '/support/vcr_cassettes'
  c.hook_into :fakeweb
end
