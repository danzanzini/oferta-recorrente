# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  belongs_to :organization
  enum role: { supporter: 0, admin: 1, producer: 2 }

  acts_as_tenant :organization
  validates_uniqueness_to_tenant :email

  validates :email, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def toggle_active!
    update_attribute!(:active, !active)
  end

  # Supporter only stuff:
  has_many :harvests
  belongs_to :location, optional: true
  delegate :current_offering, to: :location, allow_nil: false
  validates :location_id, presence: true, if: :supporter?

  def current_harvest
    harvests.current.last
  end
end
