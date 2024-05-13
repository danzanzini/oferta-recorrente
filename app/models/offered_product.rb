class OfferedProduct < ApplicationRecord
  belongs_to :offering
  belongs_to :product
end
