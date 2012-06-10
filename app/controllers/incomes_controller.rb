class IncomesController < ApplicationController
  before_filter :monthly_totals

  def create
    @transaction = current_user.add_transaction params[:commit], params[:transaction]
    if @transaction.valid?
      redirect_to new_transaction_path
    else
      render '/transactions/new'
    end
  end

  def show
    @income = current_user.income_entries.find params[:id]
  end

  def destroy
    income = current_user.income_entries.find params[:id]
    if income.delete
      redirect_to dashboard_path, :notice => 'Successfully removed income entry'
    end
  end
end

