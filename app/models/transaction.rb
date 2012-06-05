class Transaction
  include Mongoid::Document

  field :type
  field :amount
end
