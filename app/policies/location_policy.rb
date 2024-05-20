# frozen_string_literal: true

class LocationPolicy < ApplicationPolicy
  def resolve
    scope.where(organization: user.organization)
  end
end
