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

  def edit
    @income = current_user.income_entries.find params[:id]
  end

  def update
    @income = current_user.income_entries.find params[:id]
    if @income.update_attributes params[:income]
      redirect_to financial_breakdown_index
    else
      render :edit
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

