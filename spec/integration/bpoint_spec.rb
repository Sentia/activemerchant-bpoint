require 'spec_helper'

describe ActiveMerchant::Billing::BpointGateway do
 let(:options)           { { :order_id => '1', :billing_address => address, :description => 'Store Purchase' } }
 let(:valid_credit_card) { credit_card('todo: get card number') }

  context 'using invalid details' do
    let(:gateway)  { ActiveMerchant::Billing::BpointGateway.new(:login => 'does', :password => 'not_exist', :merchant_number => '8') }
    let(:response) { VCR.use_cassette('invalid login') { gateway.purchase(100, credit_card, {}) } }

    it 'is not successful' do
      response.should_not be_success
    end

    it 'returns an invalid login status' do
      response.message.should include 'invalid login'
    end
  end

  context 'making a purchase' do
    let(:gateway)             { ActiveMerchant::Billing::BpointGateway.new(:login => GATEWAY_LOGIN, :password => GATEWAY_PASSWORD, :merchant_number => GATEWAY_MERCHANT_NUMBER) }
    let(:valid_credit_card)   { credit_card(:year => 2000) }
    let(:invalid_credit_card) { credit_card(:year => 2010) }

    context 'on a valid credit card' do
      let(:response) { gateway.purchase(1000, valid_credit_card) }

      it { should be_success }
    end

    context 'on an invalid credit card' do
      let(:response) { gateway.purchase(1000, invalid_credit_card) }

      it { should_not be_success }
    end
  end

  context 'storing a credit card' do
    it 'successfully stores a valid credit card' do
      pending
    end

    it 'does not store an invalid credit card' do
      pending
    end
  end

  context 'removing a credit card from storage' do
    context 'when given a valid token' do
      it 'removes a card cord from storage' do
        pending
      end
    end

    context 'when not given a valid token' do
      it 'returns an error response' do
        pending
      end
    end
  end
end
