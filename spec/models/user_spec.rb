require "spec_helper"

describe User do
  it "has one or more income entries" do
    subject.should respond_to :income_entries
  end
  it "has one or more outgoing entries" do
    subject.should respond_to :outgoing_entries
  end

  describe "#add_transaction" do
    let(:current_user) { User.create :email => 'y@me.com', :password => 'password', :password_confirmation => 'password' }

    it "can create a new income entry" do
      params = {:type => 'Salary', :amount => '2470.00'}
      current_user.add_transaction 'income', params
    end

    it "can create a new outgoing entry" do
      current_user.outgoing_entries.should_receive :create
      params = {:type => 'Water bill', :amount => '45.00'}
      current_user.add_transaction 'outgoing', params
    end
  end

  describe "#monthly_total" do
    let(:current_user) { User.create :email => 'y@me.com', :password => 'password', :password_confirmation => 'password' }

    context "with income" do

      it "calculates the monthly income" do
        income = current_user.add_transaction 'income', { :type => 'Salary', :amount => '2400.0' }
        current_user.monthly_total.should eql income.amount.to_f
      end

      it "calculates the monthly outogoing" do
        income = current_user.add_transaction 'income', { :type => 'Salary', :amount => '2400.0' }
        outgoing = current_user.add_transaction 'outgoing', { :type => 'Debt', :amount => '240.0' }
        current_user.monthly_total.should eql income.amount.to_f - outgoing.amount.to_f
      end
    end

    it "should be able to deal with negative values" do
      outgoing = current_user.add_transaction 'outgoing', { :type => 'Debt', :amount => '240.0' }
      current_user.monthly_total.should eql -240.00
    end
  end
end
