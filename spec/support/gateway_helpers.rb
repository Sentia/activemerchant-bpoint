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

  def credit_card(number = '4242424242424242', options = {})
    defaults = {
      :number => number,
      :month => 9,
      :year => Time.now.year + 1,
      :first_name => 'Longbob',
      :last_name => 'Longsen',
      :verification_value => '123',
      :type => 'visa'
    }.update(options)

    ActiveMerchant::Billing::CreditCard.new(defaults)
  end
end
