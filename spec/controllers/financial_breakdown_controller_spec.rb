require "spec_helper"

describe FinancialBreakdownController do
  let(:user) { User.create :email => 'y@me.com', :password => 'password', :password_confirmation => 'password' }

  before do
    controller.stub(:current_user).and_return user
  end
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
