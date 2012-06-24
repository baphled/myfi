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

  describe "#next_occurrence" do
    let( :transaction ) { Transaction.create! :type => 'Food', :amount => '5.0', :bi_monthly => true}

    it "returns when the next transaction occurs" do
      transaction.next_occurrence.should eql Time.now.advance(:months => 2).to_date
    end

    context "a month passes" do
      it "sets the next transaction to the month after next" do
        Timecop.travel transaction.created_at.advance(:months => 1)
        transaction.next_occurrence.should eql transaction.created_at.advance(:months => 2).to_date
      end
    end
  end

  describe "#this_month" do
    let( :transaction ) { Transaction.create! :type => 'Food', :amount => '5.0', :bi_monthly => true }

    it "returns income from this month"
    it "returns income with the given month"

    context "4 months pass" do
      before :each do
        Timecop.travel transaction.created_at.advance(:months => 4)
        ReoccurringTransaction.update_next_occurring
      end

      it "returns reoccuring income that falls within the given month" do
        Transaction.this_month.to_a.should_not be_empty
      end
    end

    it "is empty when an income is not within the start of the month" do
      @income = Income.create :type => "Salary", :amount => '2300.00', :created_at => 5.weeks.ago.at_beginning_of_month
      Income.this_month.should be_empty
    end

    context "bi monthly transactions" do
      before :each do
        @transaction = Transaction.create! :type => 'Food', :amount => '5.0', :bi_monthly => true
      end

      it "returns empty if it does not fall on the given moth" do
        Timecop.freeze Date.today + 1.months
        Transaction.this_month.to_a.should be_empty
      end

      it "returns reoccuring income that falls within the bi monthly range" do
        Timecop.freeze Date.today + 2.months
        Transaction.this_month.to_a.should include @transaction
      end
    end
  end

  describe "#reoccurring_bi_monthly" do
    let( :transaction ) { Transaction.create! :type => 'Food', :amount => '5.0', :bi_monthly => true}

    context "current month is within the next transactional period" do
      it "returns the transaction" do
        Transaction.reoccuring_quarterly.should be_empty
        Transaction.reoccurring_bi_monthly(Time.now.advance(:months => 1)).should be_empty
        Transaction.reoccurring_bi_monthly(Time.now.advance(:months => 2)).should include transaction
      end
    end
  end

  describe "#reoccuring_quarterly" do
    let( :transaction ) { Transaction.create! :type => 'Food', :amount => '5.0', :quarterly => true}

    it "returns the transaction if within the initial transaction" do
      Transaction.reoccuring_quarterly(Time.now.advance(:months => 3)).should include transaction
    end

    context "not within the next transaction month" do
      it "is not returned" do
        Transaction.reoccuring_quarterly.should be_empty
        Transaction.reoccuring_quarterly(Time.now.advance(:months => 1)).should be_empty
        Transaction.reoccuring_quarterly(Time.now.advance(:months => 2)).should be_empty
      end
    end

    context "current month is equal to the first quarterly transaction" do
      it "returns the transaction"
    end
  end

  describe "#reoccuring_custom_range" do
    let( :transaction ) { Transaction.create! :type => 'Food', :amount => '5.0', :custom_range => true, :reoccurring_months => 5 }

    it "returns the transaction when within the initial transaction month" do
      transaction.next_occurrence.should eql Date.today + 5.months
      Transaction.reoccuring_quarterly(Time.now.advance(:months => 5)).should include transaction
    end
  end
end
