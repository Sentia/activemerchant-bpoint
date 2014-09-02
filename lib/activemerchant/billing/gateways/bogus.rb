module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    # Bogus Gateway
    class BogusGateway < Gateway

      def pre_auth(money, paysource, options = {})
        money = amount(money)
        case normalize(paysource)
        when /1$/, AUTHORIZATION
          Response.new(true, SUCCESS_MESSAGE, {:paid_amount => money, :receipt_number => '1234'}, :test => true, :authorization => AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {:paid_amount => money, :error => FAILURE_MESSAGE },:test => true)
        else
          raise Error, error_message(paysource)
        end
      end

       def refund(money, reference, options = {})
        money = amount(money)
        case reference
        when /1$/
          raise Error, REFUND_ERROR_MESSAGE
        when /2$/
          Response.new(false, FAILURE_MESSAGE, {:paid_amount => money, :error => FAILURE_MESSAGE, authorisation_result: 'FAILED' }, :test => true)
        else
          Response.new(true, SUCCESS_MESSAGE, {:paid_amount => money, :receipt_number => '1234', authorisation_result: 'Approved'}, :test => true, :authorization => AUTHORIZATION)
        end
      end
    end
  end
end
