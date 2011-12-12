require 'spec_helper'

describe ActiveMerchant::Billing::BpointGateway do
 let(:options)           { { :order_id => '1', :billing_address => address, :description => 'Store Purchase' } }
 let(:valid_credit_card) { credit_card('todo: get card number') }

  context 'using invalid details' do
    let(:gateway)  { ActiveMerchant::Billing::BpointGateway.new(:login => 'does', :password => 'not_exist', :merchant_number => '8') }
    let(:response) { gateway.purchase(100, credit_card, {}) }

    it 'is not successful' do
      response.should_not be_success
    end

    it 'returns an invalid login status' do
      response.message.should include 'invalid login'
    end
  end
end
