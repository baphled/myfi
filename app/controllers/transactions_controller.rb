class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @income = Income.all
  end

  def create
    Income.create params[:transaction]
    redirect_to new_transaction_path
  end

end
