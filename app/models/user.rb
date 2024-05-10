# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  belongs_to :organization

  enum role: { supporter: 0, admin: 1, producer: 2 }

  acts_as_tenant :organization
  validates_uniqueness_to_tenant :email

  def name
    "#{first_name} #{last_name}"
  end

  def toggle_active!
    update_attribute!(:active, !active)
  end
end
