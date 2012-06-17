require "spec_helper"

describe Income do
  describe "#this_month" do
    it "returns income for created this month" do
      Income.should_receive(:any_of)
      Income.this_month
    end

    it "is empty when an income is not within the start of the month" do
      @income = Income.create :type => "Salary", :amount => '2300.00', :created_at => 5.weeks.ago.at_beginning_of_month
      Income.this_month.should be_empty
    end

    context "there is an reoccurring income" do
      it "see a reoccurring income" do
        @income = Income.create :type => "Salary", :amount => '2300.00',:reoccurring => true, :starting_from => Time.now, :reoccurring_until => Time.now.advance(:months => 6) 
        start_of_the_month = Time.now.advance :months => 6
        Income.this_month(start_of_the_month).to_a.should include @income
      end

      it "sees the reoccurring income after 6 months have passed" do
        @income = Income.create :type => "Salary", :amount => '2300.00',:reoccurring => true, :starting_from => Time.now, :reoccurring_until => Time.now.advance(:months => 6) 
        start_of_the_month = Time.now.advance :months => 6
        Timecop.freeze start_of_the_month
        Income.this_month.to_a.should include @income
      end
    end
  end

  describe "#monthly_breakdown" do
    it "gets a list of income for this month" do
      @income = Income.create :type => "Salary", :amount => '2300.00'
      Income.monthly_breakdown.to_a.should eql [@income]
    end
  end

  describe "#monthly_breakdown_by_type" do
    it "returns a list of income" do
      Income.monthly_breakdown_by_type.should be_an Hash
    end

    it "it groups results by type" do
      @income1 = Income.create :type => "Salary", :amount => '2300.00'
      @income2 = Income.create :type => "Freelance", :amount => '100.00'
      expected = {
        'Salary' => [@income1],
        'Freelance' => [@income2]
      }
      Income.monthly_breakdown_by_type.should eql expected
    end
  end

  describe "validations" do
    it "does not need a end date"
  end

  describe "#next_transaction" do
    let( :income ) { Income.create! :type => 'Food', :amount => '5.0', :bi_monthly => true}

    it "returns when the next transaction occurs" do
      income.next_transaction.should eql Time.now.advance(:months => 2).to_date
    end

    context "a month passes" do
      it "sets the next transaction to the month after next" do
        Timecop.travel income.created_at.advance(:months => 1)
        income.next_transaction.should eql income.created_at.advance(:months => 2).to_date
      end
    end
  end

  describe "#reoccurring_bi_monthly" do
    let( :income ) { Income.create! :type => 'Food', :amount => '5.0', :bi_monthly => true}

    context "current month is within the next transactional period" do
      it "returns the transaction" do
        Income.reoccurring_bi_monthly(Time.now.advance(:months => 1)).should be_empty
        Income.reoccurring_bi_monthly(Time.now.advance(:months => 2)).should include income
      end
    end
  end
end
