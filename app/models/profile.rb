class Profile < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true

  has_attached_file :avatar, styles: {medium: "300x300#", thumb: "100x100#", small: "50x50#"},
                    default_url: ->(attachment) {ActionController::Base.helpers.asset_path("avatar.png")}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment :avatar, size: {less_than: 1.megabytes}
  validate :birthday_future
  validates :full_name, length: {minimum: 2, maximum: 100}, unless: Proc.new { |a| a.full_name.blank? }

  def birthday_future
    if birthday.present? && birthday > Time.now.to_date
      errors.add(:birthday, "Birthday invalid")
    end
  end
end
