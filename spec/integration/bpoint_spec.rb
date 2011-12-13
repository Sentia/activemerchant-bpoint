require 'spec_helper'

describe ActiveMerchant::Billing::BpointGateway do
 let(:options)           { { :order_id => '1', :billing_address => address, :description => 'Store Purchase' } }
 let(:valid_credit_card) { credit_card('todo: get card number') }

  context 'using invalid details' do
    let(:my_gateway) { gateway(:login => 'does', :password => 'not_exist', :merchant_number => '8') }
    let(:response)   { VCR.use_cassette('invalid login') { my_gateway.purchase(100, credit_card, {}) } }

    it 'is not successful' do
      response.should_not be_success
    end

    it 'returns an invalid login status' do
      response.message.should include 'invalid login'
    end
  end

  context 'making a purchase' do
    let(:valid_credit_card)   { credit_card('5123456789012346', :year => 2100) }
    let(:invalid_credit_card) { credit_card('5123456789012346', :year => 2010) }

    context 'on a valid credit card' do
      subject { VCR.use_cassette('valid CC purchase') { gateway.purchase(1000, valid_credit_card) } }

      it { should be_success }

      it 'should return an authorization ID' do
        subject.authorization.should be_present
      end
    end

    context 'on an invalid credit card' do
      subject { VCR.use_cassette('invalid CC purchase') { gateway.purchase(1000, invalid_credit_card) } }

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
