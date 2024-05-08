# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :require_login
  def home
    render 'home'
  end
end
