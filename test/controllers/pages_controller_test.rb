# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    log_in_as(@user)
  end

  test 'should get home' do
    get root_url
    assert_response :success
  end
end
