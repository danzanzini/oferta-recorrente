# frozen_string_literal: true

class Offering < ApplicationRecord
  belongs_to :location
  acts_as_tenant :organization

  has_many :harvests, dependent: :destroy, inverse_of: :offering
  has_many :harvested_products, through: :harvests
  has_many :offered_products, dependent: :destroy, inverse_of: :offering
  has_many :products, through: :offered_products

  accepts_nested_attributes_for :offered_products, allow_destroy: true, reject_if: :all_blank

  scope :open_now, lambda {
    where('opens_at <= ?', Time.zone.now)
      .where('closes_at >= ?', Time.zone.now)
  }

  scope :active, -> { where(active: true) }

  validates :opens_at, :closes_at, presence: true
  validate :closes_after_opening?
  validate :no_overlapping_offering_at_location

  def status
    return 'Encerrada' if Time.zone.now > closes_at
    return 'Agendada'  if Time.zone.now < opens_at

    'Aberta'
  end

  def open?(now)
    opens_at <= now && closes_at >= now
  end

  def before_opening?
    opens_at > Time.now
  end

  def total_harvested
    harvested_products.joins(:product)
                      .group('products.name').order('products.name')
                      .sum('harvested_products.amount')
  end

  private

  def closes_after_opening?
    return unless closes_at && opens_at
    return unless closes_at < opens_at

    errors.add(:closes_at, 'Must be after opens_at')
  end

  def no_overlapping_offering_at_location
    return unless opens_at && closes_at && location_id
    return if closes_at <= opens_at

    overlapping = Offering.active
      .where(location_id: location_id)
      .where.not(id: id)
      .where('opens_at < ? AND closes_at > ?', closes_at, opens_at)
    errors.add(:base, 'Já existe uma oferenda aberta para este local neste período') if overlapping.exists?
  end
end
