class NegativeBalance < StandardError; end

class User < ApplicationRecord
  has_many :transactions, dependent: :destroy

  def balance
    transactions.sum(:amount)
  end

  def transfer(recipient: nil, amount: 0)
    return if amount.zero?
    return unless recipient

    ActiveRecord::Base.transaction do
      # Temporary records are create during this block, but if any thing goes wrong -> immediately rolls back
      # Transactions are not districtued accross database connections. Only work on a single database connection
      transaction.create(description: "Transfer of #{recipient.name}", amount: -amount)
      raise NegativeBalance, "Cannot transfer if it makes your balance negative." if balance.negative
      recipient.transactions.create(description: "Receive from #{name}", amount: amount)
    end
  end
end
