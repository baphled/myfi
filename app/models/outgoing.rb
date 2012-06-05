class Outgoing
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount

  def self.this_month
    where :created_at.gte => Date.today.at_beginning_of_month.to_time
  end
end
