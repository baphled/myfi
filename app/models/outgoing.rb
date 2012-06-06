class Outgoing
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount

  field :reoccuring, :type => Boolean
  field :starting_from, :type => Date
  field :reoccuring_until, :type => Date

  def self.this_month month = Time.now
    any_of(
      { :reoccuring_until.lte => month.to_time.utc, :reoccuring => true },
      { :created_at => Date.today.at_beginning_of_month..Date.today.at_end_of_month }
    )
  end

  def self.monthly_total
    this_month.empty? ? 0.0 : this_month.collect(&:amount).map(&:to_f).inject(&:+)
  end
end
