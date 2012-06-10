require "spec_helper"

describe SessionsController do
  describe "#new" do
    it "gets a new user object" do
      User.should_receive :new
      get :new
    end
  end
  
  describe "#create" do
    let(:user) { User.create :email => 'y@me.com', :password => 'password', :password_confirmation => 'password' }

    it "finds the user" do
      User.should_receive(:where).and_return [ user ]
      post :create, :user => {:email => user.email, :password => user.password}
    end

    it "authenticates the user" do
      User.should_receive(:where).and_return [ user ]
      user
        .should_receive( :authenticate )
        .with(user.password)
      post :create, :user => {:email => user.email, :password => user.password}
    end

    it "sets a success flash message" do
      User.should_receive(:where).and_return [ user ]
      user
        .stub( :authenticate )
        .with(user.password)
        .and_return true
      post :create, :user => {:email => user.email, :password => user.password}
      flash[:notice].should eql 'Successfully signed in'
    end

    it "redirects the user to their dashboard" do
      User.should_receive(:where).and_return [ user ]
      user
        .stub( :authenticate )
        .with(user.password)
        .and_return true
      post :create, :user => {:email => user.email, :password => user.password}
      response.should redirect_to financial_breakdown_index_path
    end

    context "unable to authenticate" do
      it "can not find the user" do
        User.should_receive(:where).and_return []
        post :create, :user => {:email => user.email, :password => user.password}
      end

      it "can not authenticate the user" do
        User.should_receive(:where).and_return [ user ]
        user
          .should_receive( :authenticate )
          .with(user.password)
          .and_return false
        post :create, :user => {:email => user.email, :password => user.password}
      end
    end
  end
end
