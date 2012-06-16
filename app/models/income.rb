class Income
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount

  field :reoccurring, :type => Boolean
  field :starting_from, :type => Date
  field :reoccurring_until, :type => Date

  validates_presence_of :type
  validates_presence_of :amount
  validates_numericality_of :amount

  validates_date :created_at, :allow_blank => true
  validates_date :starting_from, :if => :reoccurring?
  validates_date :reoccurring_until, :if => :reoccurring?

  validates_presence_of :starting_from, :if => :reoccurring?
  validates_presence_of :reoccurring_until, :if => :reoccurring?

  belongs_to :user

  def self.this_month month = Time.now
    any_of(
      { :reoccurring_until.lte => month.to_time.utc, :reoccurring => true },
      { :created_at => Date.today.at_beginning_of_month..Date.today.at_end_of_month }
    )
  end

  def self.monthly_breakdown
    where(:created_at => Date.today.at_beginning_of_month..Date.today.at_end_of_month)
  end

  def self.monthly_breakdown_by_type
    this_month.group_by { |item| item.type }
  end

  def self.receive_the_most_from
    monthly_breakdown_by_type.collect { |type, items|
      { :type => type, :amount => items.collect(&:amount).map(&:to_f).inject(&:+) }
    }.sort { |a,b| a[1] <=> b[1] }.first
  end
end
