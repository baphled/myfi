require "spec_helper"

describe Income do
  describe "#this_month" do
    it "returns income for created this month" do
      Income.should_receive(:any_of)
      Income.this_month
    end

    it "is empty when an income is not within the start of the month" do
      @income = Income.create :created_at => 5.weeks.ago.at_beginning_of_month
      Income.this_month.should be_empty
    end

    context "there is an reoccuring income" do
      it "see a reoccuring income" do
        @income = Income.create :reoccuring => true, :starting_from => Time.now, :reoccuring_until => Time.now.advance(:months => 6) 
        start_of_the_month = Time.now.advance :months => 6
        Income.this_month(start_of_the_month).to_a.should include @income
      end

      it "sees the reoccuring income after 6 months have passed" do
        @income = Income.create :reoccuring => true, :starting_from => Time.now, :reoccuring_until => Time.now.advance(:months => 6) 
        start_of_the_month = Time.now.advance :months => 6
        Timecop.freeze start_of_the_month
        Income.this_month.to_a.should include @income
      end
    end
  end
end
