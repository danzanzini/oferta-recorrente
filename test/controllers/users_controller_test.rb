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
    { user: { email: nil } }
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'index shows location and item limit for supporters' do
    get users_url
    assert_match locations(:one).name, response.body
    assert_match users(:supporter).item_limit.to_s, response.body
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

  test 'admin can deactivate an active user' do
    target = users(:supporter)
    assert target.active?
    post toggle_active_user_url(target)
    assert_not target.reload.active?
    assert_redirected_to user_url(target)
  end

  test 'admin can activate a deactivated user' do
    target = users(:supporter)
    target.update!(active: false)
    post toggle_active_user_url(target)
    assert target.reload.active?
    assert_redirected_to user_url(target)
  end

  test 'should get edit_password' do
    get edit_password_users_url
    assert_response :success
  end

  test 'should update password successfully' do
    patch update_password_users_url, params: { user: { password: 'newpassword', password_confirmation: 'newpassword' } }
    assert_redirected_to root_path
  end

  test 'should not update password when confirmation does not match' do
    patch update_password_users_url, params: { user: { password: 'newpassword', password_confirmation: 'wrongpassword' } }
    assert_response :unprocessable_entity
  end

  test 'unauthenticated user cannot access edit_password' do
    delete logout_url
    get edit_password_users_url
    assert_redirected_to new_session_url
  end

  test 'non-admin cannot toggle active' do
    log_in_as(users(:supporter))
    target = users(:admin)
    post toggle_active_user_url(target)
    assert_redirected_to root_path
  end
end
