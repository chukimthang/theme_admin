class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, class_name: "Profile", foreign_key: "user_id", dependent: :destroy

  accepts_nested_attributes_for :profile
end
