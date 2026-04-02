class Harvest < ApplicationRecord
  belongs_to :offering
  belongs_to :user
  has_many :harvested_products, dependent: :destroy, inverse_of: :harvest

  accepts_nested_attributes_for :harvested_products, allow_destroy: true, reject_if: :all_blank

  scope :current, -> { where(offering_id: Offering.visible_to_supporters) }

  validate :within_subscription_limit

  def total_items
    harvested_products.reject(&:marked_for_destruction?).sum { |hp| hp.amount.to_i }
  end

  private

  def within_subscription_limit
    limit = user&.item_limit
    return unless limit

    if total_items > limit
      errors.add(:base, "Quantidade total excede o limite da assinatura (#{limit} itens)")
    end
  end
end
