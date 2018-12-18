class Group < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :user_id
  validates_length_of :name, :maximum => 150
end
