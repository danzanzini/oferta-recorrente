class Harvest < ApplicationRecord
  belongs_to :offering
  belongs_to :user

  has_many :harvested_products, dependent: :destroy, inverse_of: :harvest
end
