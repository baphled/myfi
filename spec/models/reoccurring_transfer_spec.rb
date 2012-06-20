require "spec_helper"

describe ReoccurringTransfer do
  let( :transfer ) { Transfer.create! :type => 'Food', :amount => '5.0', :bi_monthly => true }

  describe "#update_next_occurring" do
    it "can update all reoccurring transfers" do
      Timecop.travel transfer.created_at.advance(:months => 4)
      ReoccurringTransfer.update_next_occurring
      transfer.reload
      transfer.next_occurrence.should eql transfer.created_at.advance(:months => 4).to_date
    end
  end
end
