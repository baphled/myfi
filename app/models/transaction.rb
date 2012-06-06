class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount

  def self.monthly_total
    Income.monthly_total - Outgoing.monthly_total
  end
end
