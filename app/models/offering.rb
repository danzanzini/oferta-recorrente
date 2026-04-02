# frozen_string_literal: true

class Offering < ApplicationRecord
  belongs_to :location
  acts_as_tenant :organization

  has_many :harvests, dependent: :destroy, inverse_of: :offering
  has_many :harvested_products, through: :harvests
  has_many :offered_products, dependent: :destroy, inverse_of: :offering
  has_many :products, through: :offered_products

  accepts_nested_attributes_for :offered_products, allow_destroy: true, reject_if: :all_blank

  enum publish_status: { scheduled: 0, open: 1, closed: 2, unpublished: 3 }

  scope :open_now, lambda {
    where('opens_at <= ?', Time.zone.now)
      .where('closes_at >= ?', Time.zone.now)
  }

  scope :active, -> { where(active: true) }

  scope :visible_to_supporters, lambda {
    now = Time.zone.now
    where(publish_status: :open).or(
      where(publish_status: :scheduled)
        .where('opens_at <= ? AND closes_at >= ?', now, now)
    )
  }

  validates :opens_at, :closes_at, presence: true
  validate :closes_after_opening?
  validate :no_overlapping_offering_at_location

  def status
    case publish_status
    when 'scheduled'   then 'Agendada'
    when 'open'        then 'Aberta'
    when 'closed'      then 'Encerrada'
    when 'unpublished' then 'Despublicada'
    end
  end

  def transition_status!
    return if unpublished?

    now = Time.zone.now
    if (scheduled? || open?) && now > closes_at
      update_columns(publish_status: :closed)
    elsif scheduled? && now >= opens_at
      update_columns(publish_status: :open)
    end
  end

  def open_at?(time)
    opens_at <= time && closes_at >= time
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
