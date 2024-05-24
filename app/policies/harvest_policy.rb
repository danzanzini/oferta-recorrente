# frozen_string_literal: true

class HarvestPolicy < ApplicationPolicy

  def show?
    user.supporter?
  end

  def create?
    user.supporter? && user.current_offering && !user.current_harvest
  end

  def new?
    create?
  end

  def update?
    user.supporter? && user.current_harvest&.id == record.id
  end

  def edit?
    update?
  end
end
