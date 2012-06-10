class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create params[:user]
    if @user.valid?
      redirect_to financial_breakdown_index_path, :notice => 'Successfully created account'
    end
  end
end
