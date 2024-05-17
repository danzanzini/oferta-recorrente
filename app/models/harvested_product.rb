# frozen_string_literal: true

class HarvestedProduct < ApplicationRecord
  belongs_to :harvest
  belongs_to :offered_product
  has_one :user, through: :harvest

  delegate :product_name, to: :offered_product, prefix: false

  scope :from_user, ->(user) { joins(:harvest).where(harvests: { user: }).last }
end
