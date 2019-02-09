class Transaction < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :group

  validates :amount, presence: true, numericality: {greater_than: 0, less_than: 100000000000000}
  validates :description, length: {minimum: 2, maximum: 255}
  validates :category_id, presence: true, if: :expense?

  enum kind: [:expense, :income]

  after_create :add_buget
  after_destroy :destroy_buget

  private

  def add_buget
    total_buget = self.expense? ? (group.total_buget - amount) : (group.total_buget + amount) 
    group.update_attributes(total_buget: total_buget)
  end

  def destroy_buget
    total_buget = self.expense? ? (group.total_buget + amount) : (group.total_buget - amount) 
    group.update_attributes(total_buget: total_buget)
  end
end
