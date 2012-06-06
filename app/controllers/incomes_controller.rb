class IncomesController < ApplicationController
  before_filter :monthly_totals

  def create
    @transaction = Transaction.add params[:commit], params[:income]
    if @transaction.valid?
      redirect_to new_transaction_path
    else
      render '/transactions/new'
    end
  end
end

