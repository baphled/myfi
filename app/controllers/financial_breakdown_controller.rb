class FinancialBreakdownController < ApplicationController
  before_filter :monthly_totals
  def index
    @income_breakdown = current_user.income_entries.monthly_breakdown
    @outgoing_breakdown = current_user.outgoing_entries.monthly_breakdown
  end
end
