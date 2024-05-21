# frozen_string_literal: true

class HarvestPolicy < ApplicationPolicy

  def show?
    user.supporter?
  end

  def create?
    user.supporter? && user.current_offering
  end

  def new?
    create?
  end

  def update?
    user.supporter?
  end

  def edit?
    update?
  end
end
