class Outgoing
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount

  def self.this_month
    where(:created_at => Date.today.at_beginning_of_month..Date.today.at_end_of_month)
  end

  def self.monthly_total
    this_month.empty? ? 0.0 : this_month.collect(&:amount).map(&:to_f).inject(&:+)
  end
end
