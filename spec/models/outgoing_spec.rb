require "spec_helper"

describe Outgoing do

  describe "#next_transaction" do
    let( :outgoing ) { Outgoing.create :created_at => Time.now.utc, :type => 'Food', :amount => '5.0', :bi_monthly => true, :reoccuring => true }

    it "returns when the next transaction occurs" do
      outgoing.next_transaction.should eql Time.now.advance(:months => 2).to_date
    end

    context "a month passes" do
      it "sets the next transaction to the month after next" do
        Timecop.travel outgoing.created_at.advance(:months => 1)
        outgoing.next_transaction.should eql outgoing.created_at.advance(:months => 2).to_date
      end
    end
  end

  describe "#this_month" do
    it "returns income from this month"
    it "returns income with the given month"
    it "returns reoccuring income that falls within the given month"
    it "returns reoccuring income that falls within the bi monthly range"
  end

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
