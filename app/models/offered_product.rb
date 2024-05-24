# frozen_string_literal: true

class OfferedProduct < ApplicationRecord
  acts_as_tenant :organization
  belongs_to :offering
  belongs_to :product
  has_many :harvested_products

  before_validation :add_organization

  delegate :name, to: :product, prefix: true

  validates :product_id, uniqueness: { scope: :offering_id }
  validates :amount, numericality: { greater_than: 0 }

  private

  def add_organization
    self.organization_id ||= offering.organization_id
  end
end
