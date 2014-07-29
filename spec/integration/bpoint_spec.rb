require 'spec_helper'

describe ActiveMerchant::Billing::BpointGateway do
  let(:options)             { { :order_id => '1', :description => 'Store Purchase' } }
  let(:success_credit_card) { credit_card('5123456789012346', :year => 2100) }
  let(:fail_credit_card)    { credit_card('5123456789012346', :year => 2010) }
  let(:invalid_credit_card) { credit_card('', :year => 2010) }

  context 'using invalid details' do
    let(:my_gateway) { gateway(:login => 'does', :password => 'not_exist', :merchant_number => '8') }
    let(:response)   { VCR.use_cassette('invalid login') { my_gateway.purchase(100, credit_card, options) } }

    it 'is not successful' do
      response.should_not be_success
    end

    it 'returns an invalid login status' do
      response.message.should include 'invalid login'
    end
  end

  context 'making a purchase' do
    context 'on a valid credit card' do
      subject { VCR.use_cassette('valid CC purchase') { gateway.purchase(1000, success_credit_card, options) } }

      it { should be_success }

      it 'should return an authorization ID' do
        subject.authorization.should be_present
      end
    end

    context 'on an invalid credit card' do
      subject { VCR.use_cassette('invalid CC purchase') { gateway.purchase(1000, fail_credit_card, options) } }

      it { should_not be_success }
    end
  end

  context 'making a pre_auth purchase' do
    context 'on a valid credit card' do
      subject { VCR.use_cassette('valid CC pre-auth') { gateway.pre_auth(1000, success_credit_card, options) } }

      it { should be_success }

      it 'should return an authorization ID' do
        subject.authorization.should be_present
      end
    end

    context 'on an invalid credit card' do
      subject { VCR.use_cassette('invalid CC pre-auth') { gateway.pre_auth(1000, fail_credit_card, options) } }

      it { should_not be_success }
    end
  end

  context 'making a refund' do
    context 'after a valid purchas' do
      let(:original) { VCR.use_cassette('valid CC purchase') { gateway.purchase(1000, success_credit_card, options) } }
      it 'should be successful' do
        response = VCR.use_cassette('valid CC refund') { gateway.refund(1000, original.params["transaction_number"]) }
        response.should be_success
      end
      it 'should return an authorization ID' do
        response = VCR.use_cassette('valid CC refund') { gateway.refund(1000, original.params["transaction_number"]) }
        response.authorization.should be_present
      end
      it 'should be rejected if invalid transaction number' do
        response = VCR.use_cassette('invalid CC refund bad transaction') { gateway.refund(1000, '1234') }
        response.params['authorisation_result'].should eq 'Original transaction not found'
      end
    end
  end

  context 'making a purchase with a stored credit card' do
    let!(:token)  { VCR.use_cassette('store valid CC') { gateway.store(success_credit_card).params['billingid'] } }

    context 'with a valid token' do
      subject { VCR.use_cassette('valid token purchase') { gateway.purchase(1000, token, options) } }

      it { should be_success }

      it 'should return an authorization ID' do
        subject.authorization.should be_present
      end
    end

    context 'on an invalid token' do
      subject { VCR.use_cassette('invalid token purchase') { gateway.purchase(1000, 'invalid', options) } }

      it { should_not be_success }
    end

  end

  context 'storing a credit card' do
    context 'for a valid credit card' do
      subject { VCR.use_cassette('store valid CC') { gateway.store(success_credit_card) } }

      it { should be_success }

      it 'should return a token' do
        subject.params['billingid'].should be_present
      end
    end

    context 'for an invalid credit card' do
      subject { VCR.use_cassette('store invalid CC') { gateway.store(invalid_credit_card) } }

      it { should_not be_success }
    end
  end

  context 'removing a credit card from storage' do
    let!(:token)  { VCR.use_cassette('store valid CC') { gateway.store(success_credit_card).params['billingid'] } }

    context 'when given a valid token' do
      subject { VCR.use_cassette('unstore valid token') { gateway.unstore(token) } }

      it { should be_success }
    end

    context 'when not given a valid token' do
      subject { VCR.use_cassette('unstore invalid token') { gateway.unstore('7') } }

      it { should_not be_success }
    end
  end
end
