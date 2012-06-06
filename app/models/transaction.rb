class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount
  field :reoccuring, :type => Boolean
  field :starting_from
  field :reoccuring_until

  def self.monthly_total
    Income.monthly_total - Outgoing.monthly_total
  end
end
