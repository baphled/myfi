class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @monthly_income = Income.monthly_total
    @monthly_outgoing = Outgoing.monthly_total
    @monthly_total = Transaction.monthly_total
  end

  def create
    @transaction = Transaction.add params[:commit], params[:transaction]
    if @transaction.valid?
      redirect_to new_transaction_path
    else
      render :new
    end
  end
end
