# activemerchant-bpoint

ActiveMerchant Bpoint is an add-on for ActiveMerchant which provides a gateway for the Commonwealth Bank of Australia's BPOINT merchant gateway. Development on the gem has been sponsored by [Sentia Australia](http://www.sentia.com.au/).

## Installation
Before installing the gem you should have a BPOINT account ready to use. If not then [Contact the commonwealth bank of australia for more info.](http://www.bpoint.com.au/bpoint/business/contact.html)

To install simply add the following line to your `Gemfile` and then run `bundle install`:

``` ruby
gem 'activemerchant-bpoint'
```

The gateway can be initialised by passing your login details like so:

``` ruby
gateway = ActiveMerchant::Billing::BpointGateway.new(:login => 'login', :password => 'pass', :merchant_number => 'num')
```

## Usage
Once you have an initialised gateway, there are several public methods available including `purchase`, `store` and `unstore`.

Here is an example of using the purchase method:

``` ruby
amount     = 1000 # 1000 cents is $10.00 AUD
options    = { :order_id => '5' } # Store the customers order number at the gateway

creditcard = ActiveMerchant::Billing::CreditCard.new(
      :number => '4111111111111111',
      :month => 8,
      :year => 2006,
      :first_name => 'Longbob',
    :last_name => 'Longsen'
)

response = gateway.purchase(amount, creditcard, options)

if response.sucess?
  puts "All OK!"
else
  puts response.message # Output the error message
end
```

You can also store credit card numbers at the BPOINT gateway and then pass the token to `purchase()` like so:

``` ruby
amount     = 1000 # 1000 cents is $10.00 AUD
tptions    = { :order_id => '5' } # Store the customers order number at the gateway

creditcard = ActiveMerchant::Billing::CreditCard.new(
      :number => '4111111111111111',
      :month => 8,
      :year => 2006,
      :first_name => 'Longbob',
    :last_name => 'Longsen'
)


token = gateway.store(credit_card).params['token']

response = gateway.purchase(amount, token, options)

# ...

```

## Using test mode
As [noted in the BPOINT developer documenation in regards to testing](https://www.bpoint.com.au/backoffice/Views/Bpoint/Support/HelpGuids/TechExtracts/Testing(Phone,Internet,DDCC\).pdf) the gateway can be put into test mode by sending a month value of `99`. The initialiser for the gateway takes an optional test argument which will put it into test mode like so:

``` ruby
ActiveMerchant::Billing::BpointGateway.new(:login => 'l', :password => 'p', :merchant_number => 'n', :test => true)
```

When the gateway is in test mode then all requests will automatically have the month set to 99 (which triggers test mode on the gateway). The last 2 digits of the year is then used to determine which response code the gateway returns. The caveat with this is that you cannot have a successful status (year 2000 or 2100) and have a valid `ActiveMerchant::Billing::CreditCard`. To get around this you can pass the parameter `:force_success => true` with the options to the purchase method. This will result in a successful transaction.

``` ruby
gateway = ActiveMerchant::Billing::BpointGateway.new(:login => 'l', :password => 'p', :merchant_number => 'n', :test => true)

# ...
options  = { :force_success => true, :customer_id => '9' }
response = gateway.purchase(amount, creditcard, options)

```

Optionally you can pass the flag into the initializer for the gateway to always force success:

``` ruby
ActiveMerchant::Billing::BpointGateway.new(:login => 'l', :password => 'p', :merchant_number => 'n', :test => true, :force_success => true
```

## License

activemerchant-bpoint is distributed under a standard MIT license, see [LICENSE](https://github.com/Sentia/activemerchant-bpoint/blob/master/LICENSE) for further information.

## Contributing

Fork on GitHub and after you’ve committed tested patches, send a pull request.

To get tests running simply `run bundle install` and then `rspec spec`.

The test suite performs some remote tests by hitting the gateway and uses the VCR gem which prerecords responses. This means that you do not need to enter any details to perform the remote tests. If you do need to add new actions which hit the gateway, or rerecord responses, simply add your point details to the `spec/test_credentials.rb` file.
