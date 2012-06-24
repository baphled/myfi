require_relative "transaction"

class ReoccurringTransaction

  class << self
    def update_next_occurring
      Transaction.find_next_occurring_transactions.each(&:next_occurrence!)
    end
  end
end
