class HarvestedProduct < ApplicationRecord
  belongs_to :harvest
  belongs_to :offered_product
end
