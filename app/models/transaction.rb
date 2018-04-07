class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :date, presence: true
  validates :user_id, presence: true
  validates :description, presence: true, length: { minimum: 2 }
  validates :price, presence: true
  validates :category_id, presence: true

  validate :transaction_is_unique

  private

  def transaction_is_unique
    if Transaction.where(date: self.date, user_id: self.user, description: self.description, price: self.price, category: self.category).any?
      errors.add(:transaction, "already existing transaction")
    end
  end
end
