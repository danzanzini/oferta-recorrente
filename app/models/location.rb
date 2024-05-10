class Location < ApplicationRecord
  belongs_to :organization
  acts_as_tenant :organization
end
