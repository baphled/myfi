class TransactionsController < ApplicationController
  before_filter :monthly_totals

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.add_transaction params[:commit], params[:transaction]
    if @transaction.valid?
      redirect_to new_transaction_path
    else
      render :new
    end
  end
end
