class Transfer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type
  field :amount

  field :reoccurring, :type => Boolean
  field :bi_monthly, :type => Boolean
  field :quarterly, :type => Boolean

  field :custom_range, :type => Boolean
  field :reoccurring_months, :type => Integer

  field :starting_from, :type => Date
  field :reoccurring_until, :type => Date
  field :next_occurrence, :type => Date, default: -> { default_next_reoccurence }

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

  scope :reoccurring_bi_monthly, ->(month = Time.now) {
    where( :next_occurrence => month.at_beginning_of_month..month.at_end_of_month )
  }

  scope :find_next_occurring_transactions, ->{
    any_of(
      {:bi_monthly => true },
      {:quarterly => true },
      {:custom_range => true }
    )
  }

  scope :reoccuring_quarterly, ->( month = Time.now ) {
    where( :next_occurrence => month.at_beginning_of_month..month.at_end_of_month )
  }

  scope :this_month, ->( month = Time.now ) {
    any_of(
      { :reoccurring_until.lte => month.to_time.utc, :reoccurring => true },
      { :next_occurrence => month.at_beginning_of_month..month.at_end_of_month },
      { :created_at => month.at_beginning_of_month..month.at_end_of_month }
    )
  }

  scope :monthly_breakdown, -> {
    where(:created_at => Date.today.at_beginning_of_month..Date.today.at_end_of_month)
  }

  def self.monthly_breakdown_by_type
    this_month.group_by { |item| item.type }
  end

  def reoccurence_type
    if self.bi_monthly?
      :bimonthly
    elsif self.custom_range?
      self.reoccurring_months
    else
      :quarterly
    end
  end

  def next_occurrence!
    reoccurrence = SimplesIdeias::Recurrence.new(:every => :month, :on => self.created_at.day, :interval => reoccurence_type)
    update_attribute :next_occurrence, reoccurrence.next
    next_occurrence
  end

  protected

  def number_of_months_between_transactions
    if bi_monthly?
      2.months
     elsif custom_range?
       reoccurring_months.to_i.months
    else
      3.months
    end
  end

  def default_next_reoccurence
    Date.today + number_of_months_between_transactions
  end
end
