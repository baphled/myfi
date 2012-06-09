class FinancialBreakdownController < ApplicationController
  before_filter :monthly_totals
  def index
    @income_breakdown = Income.monthly_breakdown
    @outgoing_breakdown = Outgoing.monthly_breakdown
  end
end
