require 'activemerchant-bpoint'
require 'support/gateway_helpers'

RSpec.configure do |config|
  config.include GatewayHelpers
end

GATEWAY_LOGIN           = ''
GATEWAY_PASSWORD        = ''
GATEWAY_MERCHANT_NUMBER = ''
