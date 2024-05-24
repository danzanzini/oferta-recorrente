class Location < ApplicationRecord
  acts_as_tenant :organization
  has_many :offerings

  validates :name, :pickup_place, :address, presence: true
  def current_offering
    offerings.open_now.last
  end
end
