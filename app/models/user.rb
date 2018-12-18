class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, class_name: "Profile", foreign_key: "user_id", dependent: :destroy
  has_many :groups, -> { with_deleted }

  accepts_nested_attributes_for :profile
end
