module ActiveMerchant
  module Billing
    class BpointGateway < Gateway
      LIVE_URL = 'https://www.bpoint.com.au/evolve/service.asmx'

      self.supported_cardtypes = [:visa, :master, :american_express, :discover]
      self.supported_countries = ['AU']
      self.homepage_url        = 'http://www.bpoint.com.au'
      self.display_name        = 'BPOINT'
      self.default_currency    = 'AUD'

      def initialize(options = {})
        requires!(options, :login, :password, :merchant_number)
        @options = options
        super
      end

      def authorize(money, creditcard, options = {})
        post = {}
        add_invoice(post, options)
        add_creditcard(post, creditcard)
        add_address(post, creditcard, options)
        add_customer_data(post, options)

        commit('authonly', money, post)
      end

      def purchase(money, creditcard, options = {})
        post = {}
        add_invoice(post, options)
        add_creditcard(post, creditcard)
        add_address(post, creditcard, options)
        add_customer_data(post, options)

        commit('sale', money, post)
      end

      def capture(money, authorization, options = {})
        commit('capture', money, post)
      end

      private

      def add_customer_data(post, options)
      end

      def add_address(post, creditcard, options)
      end

      def add_invoice(post, options)
      end

      def add_creditcard(post, creditcard)
      end

      def parse(body)
      end

      def commit(action, money, parameters)
        parameters[:Amount] = amount(money)

        response = parse(ssl_post(LIVE_URL, post_data(parameters)) )
      end

      def message_from(response)
      end

      def post_data(action, parameters = {})
        xml   = REXML::Document.new
        root  = xml.add_element('txnReq')

        parameters.each { |key, value| root.add_element(key).text = value }

        xml.add_element('username', @options[:login])
        xml.add_element('password', @options[:password])
        xml.add_element('merchantNumber', @options[:merchant_number])

        xml.to_s
      end
    end
  end
end
