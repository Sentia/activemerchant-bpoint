#
# Fill in your gateway details below to test remotely (when not using VCR
# prerecorded responses). This should only be neccessary when rerecording
# existing actions or adding new remote tests
#
#
# If you want git to ignore changes to this file (so you do not accidently
# commit your API details then simply run:
# git update-index --assume-unchanged spec/test_credentials.rb
#

# UNCOMMENT THE FOLLOWING CODE  if you wish to target UAT
# class ActiveMerchant::Billing::BpointGateway
#   LIVE_URL = 'https://bpoint-uat.premier.com.au/evolve/service.asmx'
#   self.homepage_url = 'http://bpoint-uat.premier.com.au'
# end

GATEWAY_LOGIN           = ''
GATEWAY_PASSWORD        = ''
GATEWAY_MERCHANT_NUMBER = ''
