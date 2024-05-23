# frozen_string_literal: true

class Offering < ApplicationRecord
  belongs_to :location
  belongs_to :organization
  acts_as_tenant :organization

  has_many :offered_products, dependent: :destroy, inverse_of: :offering
  has_many :products, through: :offered_products

  accepts_nested_attributes_for :offered_products, allow_destroy: true, reject_if: :all_blank

  scope :open_now, lambda {
    where('opens_at <= ?', Time.zone.now)
      .where('closes_at >= ?', Time.zone.now)
  }

  validates :opens_at, :closes_at, presence: true
  validate :closes_after_opening?

  def open?(now)
    opens_at <= now && closes_at >= now
  end

  def before_opening?
    opens_at > Time.now
  end

  private

  def closes_after_opening?
    return unless closes_at < opens_at

    errors.add(:closes_at, 'Must be after opens_at')
  end
end
