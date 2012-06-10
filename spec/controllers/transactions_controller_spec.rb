require "spec_helper"

describe TransactionsController do
  let(:user) { User.create :email => 'y@me.com', :password => 'password', :password_confirmation => 'password' }

  before do
    controller.stub(:current_user).and_return user
  end

  describe "GET new" do
    it "instantiates a new transaction" do
      Transaction.should_receive( :new )
      get :new
    end
    it "gets the total income" do
      user.should_receive( :monthly_income ).at_least( :once ).and_return 0.0
      get :new
    end

    it "gets the total outgoing" do
      user.should_receive( :monthly_outgoing ).at_least(:once).and_return 0.0
      get :new
    end
  end

  describe "POST create" do
    context "Adding income" do
      it "creates a new income entry" do
        income = Income.new
        user.should_receive( :add_transaction )
          .with('Income', { 'type' => 'Salary', 'amount' => '2400.00' })
          .and_return income
        post :create, :transaction => {:type => 'Salary', :amount => '2400.00'}, :commit => 'Income'
      end
    end

    context "Adding outgoing" do
      it "creates a new outgoing entry" do
        outgoing = Outgoing.new
        user.should_receive( :add_transaction )
          .with('Outgoing', { 'type' => 'Phone bill', 'amount' => '120.00' })
          .and_return outgoing
        post :create, :transaction => {:type => 'Phone bill', :amount => '120.00'}, :commit => 'Outgoing'
      end
    end
  end
end
