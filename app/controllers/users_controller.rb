class UsersController < ApplicationController
  skip_before_filter :ensure_authenticated

  def new
    @user = User.new
  end

  def create
    @user = User.create params[:user]
    session[:user_id] = @user.id
    if @user.valid?
      redirect_to financial_breakdown_index_path, :notice => 'Successfully created account'
    end
  end
end
