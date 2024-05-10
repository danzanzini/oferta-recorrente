# test/controllers/sessions_controller_test.rb
require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should display a login form" do
    get new_session_url
    assert 'new'
  end

  test "should log in with valid credentials" do
    post session_url, params: { session: { email: @user.email, password: 'secret' } }
    assert_redirected_to root_url
    assert_equal @user.id, session[:user_id]
  end

  test "should not log in with invalid credentials" do
    post session_url, params: { email: @user.email, password: 'wrong' }
    assert 'new'
    assert_nil session[:user_id]
  end

  test "should log out" do
    delete session_url(@user)
    assert_redirected_to root_url
    assert_nil session[:user_id]
  end
end
