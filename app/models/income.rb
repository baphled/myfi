class Income < Transaction
  def self.receive_the_most_from
    monthly_breakdown_by_type.collect { |type, items|
      { :type => type, :amount => items.collect(&:amount).map(&:to_f).inject(&:+) }
    }.sort { |a,b| a[1] <=> b[1] }.first
  end
end
