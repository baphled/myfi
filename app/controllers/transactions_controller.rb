class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @monthly_income = Income.monthly_total
    @monthly_outgoing = Outgoing.monthly_total
  end

  def create
    Income.create params[:transaction] if params[:commit] == 'Income'
    Outgoing.create params[:transaction] if params[:commit] == 'Outgoing'
    redirect_to new_transaction_path
  end
end
