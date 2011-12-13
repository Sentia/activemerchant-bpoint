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
end
