# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :require_login
  def home
    if current_user.supporter?
      @current_harvest = current_user.current_harvest
      @last_harvest = current_user.harvests.order(:created_at).last
    end
    render 'home'
  end
end
