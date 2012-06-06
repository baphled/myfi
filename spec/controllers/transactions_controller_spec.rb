require "spec_helper"

describe TransactionsController do
  describe "GET new" do
    it "instantiates a new transaction" do
      Transaction.should_receive( :new )
      get :new
    end
    it "gets the total income" do
      Income.should_receive( :monthly_total ).at_least( :once ).and_return 0.0
      get :new
    end

    it "gets the total outgoing" do
      Outgoing.should_receive( :monthly_total ).at_least(:once).and_return 0.0
      get :new
    end
  end

  describe "POST create" do
    context "Adding income" do
      it "creates a new income entry" do
        Income.should_receive( :create ).with('type' => 'Salary', 'amount' => '2400.00')
        post :create, :transaction => {:type => 'Salary', :amount => '2400.00'}, :commit => 'Income'
      end
    end

    context "Adding outgoing" do
      it "creates a new outgoing entry" do
        Income.should_not_receive(:create)
        Outgoing.should_receive(:create).with('type' => 'Phone bill', 'amount' => '120.00')
        post :create, :transaction => {:type => 'Phone bill', :amount => '120.00'}, :commit => 'Outgoing'
      end
    end
  end
end
