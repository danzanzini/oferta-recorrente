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
    user.admin? || user.producer?
  end

  def update?
    user.admin? || user.producer?
  end

  def edit?
    user.admin? || user.producer?
  end

  def destroy?
    user.admin? || user.producer?
  end
end
