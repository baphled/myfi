class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount
end
