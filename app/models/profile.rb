class Profile < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true
end
