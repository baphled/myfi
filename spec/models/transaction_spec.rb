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

  describe "#monthly_total" do
    it "calculates the monthly income" do
      income = Income.create :type => 'Salary', :amount => '2400.00'
      Transaction.monthly_total.should eql Income.monthly_total
    end

    it "calculates the monthly outogoing" do
      income = Income.create :type => 'Salary', :amount => '2400.00'
      outogoing = Outgoing.create :type => 'Debt', :amount => '240.00'
      Transaction.monthly_total.should eql Income.monthly_total - Outgoing.monthly_total
    end
  end
end
