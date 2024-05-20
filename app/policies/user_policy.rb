# frozen_string_literal: true

class UserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.where(organization: user.organization)
    end
  end
end
