# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  acts_as_tenant :organization

  enum role: { supporter: 0, admin: 1, producer: 2 }

  validates_uniqueness_to_tenant :email

  validates :email, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def toggle_active!
    update_attribute!(:active, !active)
  end

  def generate_password_reset_token!
    self.password_reset_token = SecureRandom.urlsafe_base64(16)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
  end

  def password_reset_expired?
    password_reset_sent_at < 2.hours.ago
  end

  # Supporter only stuff:
  has_many :harvests
  has_one :subscription
  delegate :location, :item_limit, to: :subscription, allow_nil: true
  delegate :current_offering, to: :location, allow_nil: true

  def current_harvest
    harvests.current.last
  end

  # Producer only stuff:
  has_many :producer_locations, foreign_key: :user_id
  has_many :managed_locations, through: :producer_locations, source: :location

  def manages_location?(location)
    managed_locations.include?(location) || managed_locations.empty?
  end
end
