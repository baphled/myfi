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

  def edit
    @outgoing = current_user.outgoing_entries.find params[:id]
  end

  def update
    @outgoing = current_user.outgoing_entries.find params[:id]
    if @outgoing.update_attributes params[:outgoing]
      redirect_to financial_breakdown_index
    else
      render :edit
    end
  end

  def show
    @outgoing = current_user.outgoing_entries.find params[:id]
  end

  def destroy
    outgoing = current_user.outgoing_entries.find params[:id]
    if outgoing.delete
      redirect_to dashboard_path, :notice => 'Successfully removed outgoing entry'
    end
  end
end


