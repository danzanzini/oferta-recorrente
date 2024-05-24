# frozen_string_literal: true

class HarvestedProduct < ApplicationRecord
  acts_as_tenant :organization
  belongs_to :harvest
  belongs_to :offered_product
  has_one :user, through: :harvest

  before_validation :set_organization

  delegate :product_name, to: :offered_product, prefix: false

  scope :from_user, ->(user) { joins(:harvest).where(harvests: { user: }).last }

  private

  def set_organization
    self.organization_id = offered_product.organization_id
  end
end
