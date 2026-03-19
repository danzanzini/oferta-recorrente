# frozen_string_literal: true

class Subscription < ApplicationRecord
  acts_as_tenant :organization
  belongs_to :user
  belongs_to :location

  validates :item_limit, presence: true, numericality: { greater_than: 0 }
  validate :one_active_subscription_per_user

  private

  def one_active_subscription_per_user
    return unless active

    conflicting = Subscription.where(user_id: user_id, active: true).where.not(id: id)
    errors.add(:base, 'Usuário já possui uma assinatura ativa') if conflicting.exists?
  end
end
