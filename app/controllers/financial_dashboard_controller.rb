class FinancialDashboardController < ApplicationController
  def index
    @income_types = current_user.income_entries.monthly_breakdown_by_type
    @outgoing_type = current_user.outgoing_entries.monthly_breakdown_by_type
  end
end
