class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include Mongoid::Timestamps

  field :email
  field :password_digest, :type => String
  has_secure_password

  has_many :income_entries, :class_name => 'Income'
  has_many :outgoing_entries, :class_name => 'Outgoing'

  def add_transaction transaction_type, params = {}
    send("#{ transaction_type }_entries".downcase.to_sym).create params
  end

  def monthly_income
    income_entries.this_month.empty? ? 0.0 : income_entries.monthly_total
  end

  def monthly_outgoing
    outgoing_entries.this_month.empty? ? 0.0 : outgoing_entries.monthly_total
  end

  def monthly_total
    monthly_income - monthly_outgoing
  end
end
