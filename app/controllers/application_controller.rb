class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def monthly_totals
    @monthly_income = Income.monthly_total
    @monthly_outgoing = Outgoing.monthly_total
    @monthly_total = Transaction.monthly_total
  end
end
