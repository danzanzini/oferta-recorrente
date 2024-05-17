class HarvestedProduct < ApplicationRecord
  belongs_to :harvest
  belongs_to :offered_product

  delegate :product_name, to: :offered_product, prefix: false
end
