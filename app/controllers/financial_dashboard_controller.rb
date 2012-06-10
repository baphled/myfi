class FinancialDashboardController < ApplicationController
  def index
    @income_types = current_user.income_entries.monthly_breakdown_by_type
    @outgoing_type = current_user.outgoing_entries.monthly_breakdown_by_type
    @spent_the_most_on = current_user.outgoing_entries.spent_the_most_on
    @receive_the_most_from = current_user.income_entries.receive_the_most_from
  end
end
