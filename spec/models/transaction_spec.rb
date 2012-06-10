require "spec_helper"

describe Transaction do
  it "has a type" do
    @transaction = Transaction.new :type => 'Salary'
    @transaction.type.should eql 'Salary'
  end
  it "has a value" do
    @transaction = Transaction.new :amount => '123.00'
    @transaction.amount.should eql '123.00'
  end

  describe "#add" do
    it "can create a new income entry" do
      Income.should_receive :create
      params = {:type => 'Salary', :amount => '2470.00'}
      Transaction.add 'income', params
    end

    it "can create a new outgoing entry" do
      Outgoing.should_receive :create
      params = {:type => 'Water bill', :amount => '45.00'}
      Transaction.add 'outgoing', params
    end
  end
end
