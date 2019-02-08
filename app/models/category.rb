class Category < ApplicationRecord
  acts_as_paranoid
  
  has_many :children, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id", optional: true
  belongs_to :group
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, length: {minimum: 2, maximum: 150}
  validates_uniqueness_of :name, scope: :group_id

  def get_ancestors(level = 0, result = [])
    result.push([level, self])
    unless children.empty?
      children.each do |child|
        child.get_ancestors(level + 1, result)
      end
    end
    result if level == 0
  end
end
