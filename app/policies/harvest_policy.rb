# frozen_string_literal: true

# Policy for managing harvest actions
class HarvestPolicy < ApplicationPolicy
  def show?
    user.supporter? || user.admin? || user.producer?
  end

  def index?
    user.admin? || user.producer?
  end

  def create?
    user.supporter? && user.current_offering && !user.current_harvest
  end

  def new?
    create?
  end

  def update?
    user.admin? || (user.supporter? && user.current_harvest&.id == record.id)
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? ||
      (user.supporter? &&
        record.user_id == user.id &&
        record.offering.open_at?(Time.zone.now))
  end

  def use_harvest_offering?
    user.admin?
  end
end
