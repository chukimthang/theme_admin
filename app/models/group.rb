class Group < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :categories

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }
  validates_uniqueness_of :name, scope: :user_id
end
