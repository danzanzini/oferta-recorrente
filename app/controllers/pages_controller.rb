# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :require_login
  def home
    @current_harvest = current_user.current_harvest
    render 'home'
  end
end
