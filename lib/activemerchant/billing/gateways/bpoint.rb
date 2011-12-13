module ActiveMerchant
  module Billing
    class BpointGateway < Gateway
      LIVE_URL = 'https://www.bpoint.com.au/evolve/service.asmx'

      self.supported_cardtypes = [:visa, :master, :american_express, :discover]
      self.supported_countries = ['AU']
      self.homepage_url        = 'http://www.bpoint.com.au'
      self.display_name        = 'BPOINT'
      self.default_currency    = 'AUD'
      self.money_format        = :cents

      def initialize(options = {})
        requires!(options, :login, :password, :merchant_number)
        @options = options
        super
      end

      def purchase(money, creditcard, options = {})
        post = {}
        add_invoice(post, options)
        add_creditcard(post, creditcard, options)

        commit('ProcessPayment', money, post)
      end

      def store(credit_card, options = {})
        post = {}
        add_creditcard(post, credit_card, options)

        commit('AddToken', nil, post)
      end

      def unstore(token, options = {})
        post = { :token => token }

        commit('DeleteToken', nil, post)
      end

      def test?
        @options[:test] || super
      end

      private

      def add_invoice(post, options)
        post[:MerchantReference] = options[:order_id]
      end

      def add_creditcard(post, creditcard, options = {})
        if test?
          creditcard.month = '99'
          creditcard.year  = '2000' if @options[:force_success] == true || options[:force_success] == true
        end

        post[:CardNumber] = creditcard.number
        post[:ExpiryDate] = "%02d%02s" % [creditcard.month, creditcard.year.to_s[-2..-1]]
        post[:CVC]        = creditcard.verification_value
        post[:CRN1]       = [creditcard.first_name, creditcard.last_name].join(' ')
      end

      def parse(body)
        return {} if body.blank?

        xml    = REXML::Document.new(body)
        result = {}.tap { |response| xml.root.elements.to_a.each { |node| parse_element(response, node) } }
      end

      def parse_element(response, node)
        return response[node.name.underscore.to_sym] = node.text unless node.has_elements?

        node.elements.each{|element| parse_element(response, element) }
      end

      def commit(action, money, parameters)
        parameters[:Amount]      = amount(money) if money.present?
        parameters[:PaymentType] = 'PAYMENT'
        parameters[:TxnType]     = 'INTERNET_ANONYMOUS'

        response = parse(ssl_post(LIVE_URL, post_data(action, parameters), 'SOAPAction' => "urn:Eve/#{action}", 'Content-Type' => 'text/xml;charset=UTF-8'))
        options  = {
          :test => test?,
          :authorization => response[:authorise_id]
        }

        Response.new(success_from(response), message_from(response), response, options)
      end

      def success_from(response)
        response[:response_code] == 'SUCCESS' && (response[:acquirer_response_code] == nil || response[:acquirer_response_code] == '00')
      end

      def message_from(response)
        response[:response_message]
      end

      def post_data(action, parameters = {})
        xml      = REXML::Document.new
        envelope = xml.add_element('env:Envelope',  { 'xmlns:xsd' =>
                                  'http://www.w3.org/2001/XMLSchema',
                                    'xmlns:xsi' =>
                                  'http://www.w3.org/2001/XMLSchema-instance',
                                    'xmlns:wsdl' => 'urn:Eve', 'xmlns:env' =>
                                  'http://schemas.xmlsoap.org/soap/envelope/',
                                    'xmlns:ns0' => 'urn:Eve'})

        body    = envelope.add_element('env:Body')
        request = body.add_element("ns0:#{action}")

        tnx_request = request.add_element('ns0:tokenRequest') if action == 'AddToken'
        tnx_request = request.add_element('ns0:txnReq') if action == 'ProcessPayment'
        tnx_request = request if tnx_request.blank?

        request.add_element('ns0:username').text       = @options[:login]
        request.add_element('ns0:password').text       = @options[:password]
        request.add_element('ns0:merchantNumber').text = @options[:merchant_number]

        parameters.each { |key, value| tnx_request.add_element("ns0:#{key}").text = value }

        xml << REXML::XMLDecl.new('1.0', 'UTF-8')
        xml.to_s
      end
    end
  end
end
