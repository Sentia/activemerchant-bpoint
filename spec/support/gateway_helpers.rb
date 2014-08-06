module GatewayHelpers
  def credit_card(number = '5123 4567 8901 2346', options = {})
    defaults = {
      :number => number,
      :month => 99,  # We need to use 99 to trigger 'Test' mode for the gatewqy
      :year => 2000, # In gateway test mode the year is used to set the response status, (2000 in YY == 00 which is approved)
      :first_name => 'Longbob',
      :last_name => 'Longsen',
      :verification_value => '123',
      :brand => 'visa'
    }.update(options)

    ActiveMerchant::Billing::CreditCard.new(defaults)
  end

  def gateway(options = {})
    endpoint = GATEWAY_ENDPOINT if defined? GATEWAY_ENDPOINT
    ActiveMerchant::Billing::BpointGateway.new({ :endpoint => endpoint, :login => GATEWAY_LOGIN, :password => GATEWAY_PASSWORD, :merchant_number => GATEWAY_MERCHANT_NUMBER }.merge(options))
  end
end
