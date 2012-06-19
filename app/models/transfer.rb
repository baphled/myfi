class Transfer
  include Mongoid::Document
  include Mongoid::Timestamps

  after_save :reoccurence, :if => lambda {|o| o.bi_monthly? or o.quarterly? }

  field :type
  field :amount

  field :reoccurring, :type => Boolean
  field :bi_monthly, :type => Boolean
  field :quarterly, :type => Boolean
  field :starting_from, :type => Date
  field :reoccurring_until, :type => Date
  field :next_occurrence, :type => Date, :default => lambda { ( bi_monthly? ) ? Date.today + 2.months : Date.today + 3.months }

  attr_accessor :reoccurence

  validates_presence_of :type
  validates_presence_of :amount
  validates_numericality_of :amount

  validates_date :created_at, :allow_blank => true
  validates_date :starting_from, :if => :reoccurring?
  validates_date :reoccurring_until, :if => :reoccurring?, :allow_blank => true

  validates_presence_of :starting_from, :if => :reoccurring?
  validates_presence_of :reoccurring_until, :if => :reoccurring?, :allow_blank => true

  belongs_to :user

  def self.reoccurring_bi_monthly month = Time.now
    where( :next_occurrence => month.at_beginning_of_month..month.at_end_of_month )
  end

  def self.reoccuring_quarterly month = Time.now
    where( :next_occurrence => month.at_beginning_of_month..month.at_end_of_month )
  end

  def self.this_month month = Time.now
    any_of(
      { :reoccurring_until.lte => month.to_time.utc, :reoccurring => true },
      { :next_occurrence => month.at_beginning_of_month..month.at_end_of_month },
      { :created_at => month.at_beginning_of_month..month.at_end_of_month }
    )
  end

  def self.monthly_breakdown
    where(:created_at => Date.today.at_beginning_of_month..Date.today.at_end_of_month)
  end

  def self.monthly_breakdown_by_type
    this_month.group_by { |item| item.type }
  end

  def next_transaction
    reoccurence
  end

  def reoccurence
    reoccurence_type = self.bi_monthly? ? :bimonthly : :quarterly
    @reoccurence ||= SimplesIdeias::Recurrence.new(:every => :month, :on => self.created_at.day, :interval => reoccurence_type, :starts => self.created_at)
    self.next_occurrence = (created_at.to_date >= @reoccurence.next) ? @reoccurence.next! : @reoccurence.next
    self.next_occurrence
  end
end
