class Offering < ApplicationRecord
  belongs_to :location
  belongs_to :organization
  acts_as_tenant :organization
end
