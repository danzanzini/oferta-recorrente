# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    log_in_as(@user)
  end

  def valid_user_params
    { user: { email: 'new_email@example.com', role: :admin } }
  end

  def invalid_user_params
    { user: { email: 'new_email@example.com' } }
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: valid_user_params
    end

    assert_redirected_to user_url(User.last)
  end

  test 'should not create user when invalid' do
    assert_no_difference('User.count') do
      post users_url, params: invalid_user_params
    end

    assert_response :unprocessable_entity
  end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: { user: { email: 'teste@example.com' } }
    assert_redirected_to user_url(@user)
  end

  test 'should not update user when invalid' do
    patch user_url(@user), params: { user: { email: nil } }
    assert_response :unprocessable_entity
  end

  test 'should destroy user' do
    delete user_url(@user)
    assert !@user.reload.active

    assert_redirected_to users_url
  end
end
