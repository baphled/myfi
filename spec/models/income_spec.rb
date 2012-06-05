require "spec_helper"

describe Income do
  describe "#this_month" do
    it "returns income for created this month" do
      Income.should_receive(:where)
      Income.this_month
    end

    it "is empty when an income is not within the start of the month" do
      @income = Income.create :created_at => 5.weeks.ago.at_beginning_of_month
      Income.this_month.should be_empty
    end
  end
end
