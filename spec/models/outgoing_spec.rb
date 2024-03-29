require "spec_helper"

describe Outgoing do
  describe "#spent_the_most_on" do
    it "returns the type and amount" do
      Outgoing.create :type => 'Gas', :amount => '10.50'
      Outgoing.create :type => 'Fast food', :amount => '6.50'
      Outgoing.create :type => 'Fast food', :amount => '6.50'
      expected = {:type => 'Fast food', :amount => 13.0}
      Outgoing.spent_the_most_on.should eql expected
    end
  end
end
