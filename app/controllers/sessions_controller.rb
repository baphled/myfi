class SessionsController < ApplicationController
  skip_before_filter :ensure_authenticated

  def new
    @user = User.new
  end

  def create
    @user = User.where( :email => params[:user][:email] ).first
    if @user and @user.authenticate(params[:user][:password])
      flash[:notice] = 'Successfully signed in'
      session[:user_id] = @user.id
      redirect_to login_path
    else
      flash[:alert] = 'Failed signed in'
      @user = User.new
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, :notice => 'Successfully signed out'
  end
end
