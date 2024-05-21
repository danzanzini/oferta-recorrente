class Harvest < ApplicationRecord
  belongs_to :offering
  belongs_to :user
  has_many :harvested_products, dependent: :destroy, inverse_of: :harvest

  accepts_nested_attributes_for :harvested_products, allow_destroy: true, reject_if: :all_blank

  scope :current, -> { where(offering_id: Offering.open_now) }
end
