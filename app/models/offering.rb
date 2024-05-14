# frozen_string_literal: true

class Offering < ApplicationRecord
  belongs_to :location
  belongs_to :organization
  acts_as_tenant :organization

  has_many :offered_products, dependent: :destroy, inverse_of: :offering
  has_many :products, through: :offered_products

  accepts_nested_attributes_for :offered_products, allow_destroy: true, reject_if: :all_blank

  def open?(now)
    opens_at <= now && closes_at >= now
  end
end
