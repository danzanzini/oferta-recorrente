class Product < ApplicationRecord
  acts_as_tenant :organization

  has_many :offered_products

  validates :name, presence: true
end
