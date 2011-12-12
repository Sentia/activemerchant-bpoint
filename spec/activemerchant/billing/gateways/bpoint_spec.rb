require 'spec_helper'

describe ActiveMerchant::Billing::BpointGateway do
  context 'on initialize' do
    it 'sets the given username' do
      pending
    end

    it 'sets the given password' do
      pending
    end

    it 'loads the given PEM SSL certificate file' do
      pending
    end
  end

  describe '#authorize' do
    it 'successfully authorizes a valid mastercard credit card' do
      pending
    end

    it 'successfully authorizes a valid visa credit card' do
      pending
    end

    it 'does not authorize an invalid mastercard credit card' do
      pending
    end

    it 'does not authorize an invalid visa credit card' do
      pending
    end
  end

  describe '#capture' do
    it 'successfully captures a valid mastercard credit card' do
      pending
    end

    it 'successfully captures a valid visa credit card' do
      pending
    end

    it 'does not capture an invalid mastercard credit card' do
      pending
    end

    it 'does not capture an invalid visa credit card' do
      pending
    end
  end

  describe '#credit' do
    it 'successfully credits a valid mastercard credit card' do
      pending
    end

    it 'successfully credits a valid visa credit card' do
      pending
    end

    it 'does not credit an invalid mastercard credit card' do
      pending
    end

    it 'does not credit an invalid visa credit card' do
      pending
    end
  end

  describe '#purchase' do
    it 'successfully performs a purchase on a valid mastercard credit card' do
      pending
    end

    it 'successfully performs a purchase on a valid visa credit card' do
      pending
    end

    it 'does not performs a purchase on an invalid mastercard credit card' do
      pending
    end

    it 'does not performs a purchase on an invalid visa credit card' do
      pending
    end
  end

  describe '#store' do
    it 'successfully stores a valid mastercard credit card' do
      pending
    end

    it 'successfully stores a valid visa credit card' do
      pending
    end

    it 'does not store an invalid mastercard credit card' do
      pending
    end

    it 'does not store an invalid visa credit card' do
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

    it 'successfully removes a credit card stores a valid mastercard credit card' do
      pending
    end

    it 'successfully stores a valid visa credit card' do
      pending
    end

    it 'does not store an invalid mastercard credit card' do
      pending
    end

    it 'does not store an invalid visa credit card' do
      pending
    end
  end
end
