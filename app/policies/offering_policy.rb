# frozen_string_literal: true

class OfferingPolicy < ApplicationPolicy
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
    create?
  end

  def update?
    (user.admin? || user.producer?) && record.before_opening?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || user.producer?
  end
end
