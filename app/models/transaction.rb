class Transaction < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :group

  validates :amount, presence: true
  validates :description, length: {minimum: 2, maximum: 255}
  validates :category_id, presence: true, if: :expense?

  enum kind: [:expense, :income]
end
