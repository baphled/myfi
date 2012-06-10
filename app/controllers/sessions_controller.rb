class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.where( :email => params[:user][:email] ).first
    if @user and @user.authenticate(params[:user][:password])
      flash[:notice] = 'Successfully signed in'
      session[:user_id] = @user.id
      redirect_to financial_breakdown_index_path
    else
      flash[:error] = 'Failed signed in'
      @user = User.new
      render :new
    end
  end
end
