require "spec_helper"

describe TransactionsController do
  describe "GET new" do
    it "instantiates a new transaction" do
      Transaction.should_receive :new
      get :new
    end
    it "gets the total income" do
      Income.should_receive :all
      get :new
    end
  end

  describe "POST create" do
    context "Adding income" do
      it "creates a new income entry" do
        Income.should_receive( :create ).with('type' => 'Salary', 'amount' => '2400.00')
        post :create, :transaction => {:type => 'Salary', :amount => '2400.00'}, :submit => 'income'
      end
    end
  end
end
