require 'spec_helper'

describe ActiveMerchant::Billing::BpointGateway do
  context 'on initialize' do
    subject { ActiveMerchant::Billing::BpointGateway.new(:login => 'foo', :password => 'bar', :merchant_number => '7') }

    it 'sets the given username' do
      subject.instance_variable_get('@options')[:login].should == 'foo'
    end

    it 'sets the given password' do
      subject.instance_variable_get('@options')[:password].should == 'bar'
    end

    it 'sets the given merchant number' do
      subject.instance_variable_get('@options')[:merchant_number].should == '7'
    end

    it 'should raise an exception if the username is missing' do
      expect { ActiveMerchant::Billing::BpointGateway.new(:password => 'bar', :merchant_number => '4') }.to raise_error ArgumentError
    end

    it 'should raise an exception if the password is missing' do
      expect { ActiveMerchant::Billing::BpointGateway.new(:login => 'foo', :merchant_number => '4') }.to raise_error ArgumentError
    end

    it 'should raise an exception if the merchant number is missing' do
      expect { ActiveMerchant::Billing::BpointGateway.new(:login => 'foo', :password => 'bar') }.to raise_error ArgumentError
    end
  end

  describe '#purchase' do
    it 'successfully performs a purchase on a valid credit card' do
      pending
    end

    it 'does not performs a purchase on an invalid credit card' do
      pending
    end
  end

  describe '#store' do
    it 'successfully stores a valid credit card' do
      pending
    end

    it 'does not store an invalid credit card' do
      pending
    end
  end

  describe '#unstore' do
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
