require_relative "transaction"

class ReoccurringTransaction

  class << self

    #
    # Iterates over all transactions that need their next occurrence updated
    # and calls next_occurrence! to update each transaction
    #
    def update_next_occurring
      next_occurrencing_transactions.each(&:next_occurrence!)
    end

    def next_occurrencing_transactions
      Transaction.find_next_occurring_transactions
    end
  end
end
