class Offering < ApplicationRecord
  belongs_to :location
  belongs_to :organization
end
