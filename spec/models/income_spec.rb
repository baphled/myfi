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

    context "there is an reoccuring income" do
      it "see a reoccuring income" do
        @income = Income.create :type => "Salary", :amount => '2300.00',:reoccuring => true, :starting_from => Time.now, :reoccuring_until => Time.now.advance(:months => 6) 
        start_of_the_month = Time.now.advance :months => 6
        Income.this_month(start_of_the_month).to_a.should include @income
      end

      it "sees the reoccuring income after 6 months have passed" do
        @income = Income.create :type => "Salary", :amount => '2300.00',:reoccuring => true, :starting_from => Time.now, :reoccuring_until => Time.now.advance(:months => 6) 
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
end
