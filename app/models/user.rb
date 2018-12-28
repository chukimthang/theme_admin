class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, class_name: "Profile", foreign_key: "user_id", dependent: :destroy
  has_many :groups, -> {with_deleted}
  has_many :user_hobbies, dependent: :destroy
  has_many :hobbies, through: :user_hobbies

  validates :email, presence: true, format: {with: /\A([a-zA-Z0-9]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, length: {minimum: 6}, allow_nil: true
  validates_confirmation_of :password

  accepts_nested_attributes_for :profile

  delegate :full_name, to: :profile, allow_nil: true, prefix: true
  delegate :gender, to: :profile, allow_nil: true
  delegate :birthday, to: :profile, allow_nil: true, prefix: true
end
