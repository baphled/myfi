class TransactionsController < ApplicationController
  def index
    @transaction = Transaction.new
  end

end
