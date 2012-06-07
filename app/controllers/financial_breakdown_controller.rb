class FinancialBreakdownController < ApplicationController
  def index
    @income_breakdown = Income.monthly_breakdown
    @outgoing_breakdown = Outgoing.monthly_breakdown
  end
end
