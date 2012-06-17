require "spec_helper"

describe Transfer do
  describe "#next_transaction" do
    let( :transfer ) { Transfer.create! :type => 'Food', :amount => '5.0', :bi_monthly => true}

    it "returns when the next transaction occurs" do
      transfer.next_transaction.should eql Time.now.advance(:months => 2).to_date
    end

    context "a month passes" do
      it "sets the next transaction to the month after next" do
        Timecop.travel transfer.created_at.advance(:months => 1)
        transfer.next_transaction.should eql transfer.created_at.advance(:months => 2).to_date
      end
    end
  end

  describe "#this_month" do
    it "returns income from this month"
    it "returns income with the given month"
    it "returns reoccuring income that falls within the given month"

    it "returns income for created this month" do
      Income.should_receive(:any_of)
      Income.this_month
    end

    it "is empty when an income is not within the start of the month" do
      @income = Income.create :type => "Salary", :amount => '2300.00', :created_at => 5.weeks.ago.at_beginning_of_month
      Income.this_month.should be_empty
    end

    context "bi monthly transactions" do

      before :each do
        @transfer = Transfer.create! :type => 'Food', :amount => '5.0', :bi_monthly => true
      end

      it "returns empty if it does not fall on the given moth" do
        Timecop.freeze Date.today + 1.months
        Transfer.this_month.to_a.should be_empty
      end

      it "returns reoccuring income that falls within the bi monthly range" do
        Timecop.freeze Date.today + 2.months
        Transfer.this_month.to_a.should include @transfer
      end
    end
  end

  describe "#reoccurring_bi_monthly" do
    let( :transfer ) { Transfer.create! :type => 'Food', :amount => '5.0', :bi_monthly => true}

    context "current month is within the next transactional period" do
      it "returns the transaction" do
        Transfer.reoccurring_bi_monthly(Time.now.advance(:months => 1)).should be_empty
        Transfer.reoccurring_bi_monthly(Time.now.advance(:months => 2)).should include transfer
      end
    end
  end
end

