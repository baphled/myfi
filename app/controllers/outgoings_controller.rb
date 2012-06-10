class OutgoingsController < ApplicationController
  before_filter :monthly_totals

  def create
    @transaction = current_user.add_transaction params[:commit], params[:transaction]
    if @transaction.valid?
      redirect_to new_transaction_path
    else
      render '/transactions/new'
    end
  end
end


