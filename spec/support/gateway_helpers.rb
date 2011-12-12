module GatewayHelpers
  def address(options = {})
    { 
      :name     => 'Jim Smith',
      :address1 => '1234 My Street',
      :address2 => 'Apt 1',
      :company  => 'Widgets Inc',
      :city     => 'Ottawa',
      :state    => 'ON',
      :zip      => 'K1C2N6',
      :country  => 'CA',
      :phone    => '(555)555-5555',
      :fax      => '(555)555-6666'
    }.update(options)
  end

  def credit_card(number = '5123456789012346', options = {})
    defaults = {
      :number => number,
      :month => 99,  # We need to use 99 to trigger 'Test' mode for the gatewqy
      :year => 2000, # In gateway test mode the year is used to set the response status, (2000 in YY == 00 which is approved)
      :first_name => 'Longbob',
      :last_name => 'Longsen',
      :verification_value => '123',
      :type => 'visa'
    }.update(options)

    ActiveMerchant::Billing::CreditCard.new(defaults)
  end
end
