class Transaction
  include ActiveAttr::Model

  attribute :type
  attribute :amount
  attribute :created_at

  attribute :reoccurring, :type => Boolean
  attribute :starting_from
  attribute :reoccurring_until

  def self.add transaction_type, params = {}
    transaction_type.capitalize.constantize.create params
  end
end
