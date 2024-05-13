class Offering < ApplicationRecord
  belongs_to :location
  belongs_to :organization
  acts_as_tenant :organization

  def is_open?(now)
    opens_at <= now && closes_at >= now
  end
end
