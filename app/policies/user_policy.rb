# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def toggle_active?
    user.admin?
  end
end
