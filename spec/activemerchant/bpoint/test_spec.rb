require 'spec_helper'

describe ActiveMerchant::Bpoint::Test do
  describe '#hello' do
    it 'should be neat' do
      ActiveMerchant::Bpoint::Test.new.hello.should == 'oh hai'
    end
  end
end
