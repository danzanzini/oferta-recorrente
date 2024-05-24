# frozen_string_literal: true

class OfferedProduct < ApplicationRecord
  belongs_to :offering
  belongs_to :product
  has_many :harvested_products
  acts_as_tenant :organization

  before_validation :add_organization

  delegate :name, to: :product, prefix: true

  private

  def add_organization
    self.organization_id ||= offering.organization_id
  end
end
