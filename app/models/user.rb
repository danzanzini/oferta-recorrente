class User < ApplicationRecord
  has_secure_password
  belongs_to :organization

  acts_as_tenant :organization
  validates_uniqueness_to_tenant :email
end
