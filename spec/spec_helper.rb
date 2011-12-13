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

#
# Fill in your gateway details below to test remotely (when not using VCR
# prerecorded responses). This should only be neccessary when rerecording
# existing actions or adding new remote tests
#
GATEWAY_LOGIN           = ''
GATEWAY_PASSWORD        = ''
GATEWAY_MERCHANT_NUMBER = ''
