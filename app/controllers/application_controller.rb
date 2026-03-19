# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  set_current_tenant_through_filter
  helper_method :current_user
  helper_method :current_organization
  helper_method :logged_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Você não tem permissão para realizar esta ação.'
    redirect_back_or_to root_path, status: :see_other
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def current_organization
    @current_organization ||= set_current_tenant(@current_user.organization)
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    return if logged_in?

    flash[:alert] = 'Please log in.'
    redirect_to new_session_url
  end
end
