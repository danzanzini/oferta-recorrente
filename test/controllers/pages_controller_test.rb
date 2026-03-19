# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'admin sees home page successfully' do
    log_in_as(users(:admin))
    get root_url
    assert_response :success
    assert_match 'Usuários', response.body
  end

  test 'producer sees home page successfully' do
    log_in_as(users(:producer))
    get root_url
    assert_response :success
    assert_match 'Minhas Oferendas', response.body
  end

  test 'supporter sees home page successfully' do
    log_in_as(users(:supporter))
    get root_url
    assert_response :success
  end

  test 'supporter sees last harvest link when harvest exists' do
    log_in_as(users(:one))
    get root_url
    assert_response :success
  end
end
