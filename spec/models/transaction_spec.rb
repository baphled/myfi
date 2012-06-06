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

    context "with income" do
      let( :income ) { Income.create :type => 'Salary', :amount => '2400.00' }

      it "calculates the monthly income" do
        Transaction.monthly_total.should eql Income.monthly_total
      end

      it "calculates the monthly outogoing" do
        outogoing = Outgoing.create :type => 'Debt', :amount => '240.00'
        Transaction.monthly_total.should eql Income.monthly_total - Outgoing.monthly_total
      end
    end

    it "should be able to deal with negative values" do
      outogoing = Outgoing.create :type => 'Debt', :amount => '240.00'
      Transaction.monthly_total.should eql -240.00
    end
  end
end
