require "spec_helper"

describe FinancialBreakdownController do
  describe "GET index" do
    it "gets this months outgoings breakdown" do
      Income.should_receive :monthly_breakdown
      get :index
    end
    it "gets this months income breakdown" do
      Outgoing.should_receive :monthly_breakdown
      get :index
    end
  end
end
