# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def toggle_active?
    user.admin?
  end

  def reset_password?
    user.admin?
  end
end
