require "spec_helper"

describe Outgoing do

  describe "#this_month" do
    context "there is an reoccuring outgoing" do
      it "see a reoccuring outgoing" do
        @outgoing = Outgoing.create :reoccuring => true, :starting_from => Time.now, :reoccuring_until => Time.now.advance(:months => 6) 
        start_of_the_month = Time.now.advance :months => 6
        Outgoing.this_month(start_of_the_month).to_a.should include @outgoing
      end

      it "sees the reoccuring outgoing after 6 months have passed" do
        @outgoing = Outgoing.create :reoccuring => true, :starting_from => Time.now, :reoccuring_until => Time.now.advance(:months => 6) 
        start_of_the_month = Time.now.advance :months => 6
        Timecop.freeze start_of_the_month
        Outgoing.this_month.to_a.should include @outgoing
      end
    end
  end
end
