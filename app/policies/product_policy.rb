# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  def index?
    user.admin? || user.producer?
  end

  def show?
    user.admin? || user.producer?
  end

  def create?
    user.admin? || user.producer?
  end

  def new?
    user.admin? || user.producer?
  end

  def update?
    user.admin? || user.producer?
  end

  def edit?
    user.admin? || user.producer?
  end

  def destroy?
    return false unless user.admin? || user.producer?

    !record.offered_products.joins(:offering).where(offerings: { active: true }).exists?
  end
end
