require_relative "transfer"

class ReoccurringTransfer

  class << self
    def update_next_occurring
      Transfer.find_next_occurring_transactions.each(&:next_occurrence!)
    end
  end
end
