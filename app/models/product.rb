class Product < ApplicationRecord
  belongs_to :organization
  acts_as_tenant :organization

  validates :name, presence: true
end
