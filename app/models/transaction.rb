class Transaction
  include ActiveAttr::Model

  attribute :type
  attribute :amount

  attribute :reoccuring, :type => Boolean
  attribute :starting_from
  attribute :reoccuring_until

  def self.monthly_total
    Income.monthly_total - Outgoing.monthly_total
  end
end
