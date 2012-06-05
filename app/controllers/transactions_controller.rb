class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @income = Income.this_month
    @outgoing = Outgoing.this_month
  end

  def create
    Income.create params[:transaction] if params[:submit] == 'income'
    Outgoing.create params[:transaction] if params[:submit] == 'outgoing'
    redirect_to new_transaction_path
  end
end
