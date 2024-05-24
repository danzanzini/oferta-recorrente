class Organization < ApplicationRecord
  has_many :users
  has_many :offerings
  has_many :offered_products
end
