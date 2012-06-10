class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_authenticated

  def current_user
    @current_user = User.find session[:user_id] if session[:user_id]
  end

  protected

  def ensure_authenticated
    if current_user
      Rails.logger.info "Request by User##{current_user.id}"
    else
      Rails.logger.warn "Unauthenticated request. Session = #{session.inspect}"
      redirect_to new_session_path, :status => 302, :alert => 'Unauthorised request'
    end
  end

  private

  def monthly_totals
    @monthly_income = Income.monthly_total
    @monthly_outgoing = Outgoing.monthly_total
    @monthly_total = Transaction.monthly_total
  end
  
  helper_method :current_user
end
