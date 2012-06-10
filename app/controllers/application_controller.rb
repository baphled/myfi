class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_user
    @current_user = User.find session[:user_id] if session[:user_id]
  end

  private

  def monthly_totals
    @monthly_income = Income.monthly_total
    @monthly_outgoing = Outgoing.monthly_total
    @monthly_total = Transaction.monthly_total
  end
  
  helper_method :current_user
end
