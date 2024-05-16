class Location < ApplicationRecord
  belongs_to :organization
  acts_as_tenant :organization

  has_many :offerings

  def current_offering
    offerings.open_now.last
  end
end
