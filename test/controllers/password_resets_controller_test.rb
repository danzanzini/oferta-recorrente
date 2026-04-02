require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'GET new renders the forgot-password form' do
    get new_password_resets_url
    assert_response :success
  end

  test 'POST create with valid email sends 1 email and redirects to login' do
    assert_emails 1 do
      post password_resets_url, params: { email: @user.email }
    end
    assert_redirected_to new_session_url
    assert_match(/instrução/, flash[:notice])
  end

  test 'POST create with unknown email sends 0 emails and still redirects' do
    assert_emails 0 do
      post password_resets_url, params: { email: 'nobody@nowhere.com' }
    end
    assert_redirected_to new_session_url
  end

  test 'GET edit with valid token returns 200' do
    ActsAsTenant.without_tenant { @user.generate_password_reset_token! }
    get edit_password_reset_url(@user.password_reset_token)
    assert_response :success
  end

  test 'GET edit with expired token redirects with alert' do
    @user.update_columns(
      password_reset_token: 'expiredtoken',
      password_reset_sent_at: 3.hours.ago
    )
    get edit_password_reset_url('expiredtoken')
    assert_redirected_to new_password_resets_url
    assert_match(/expirado/, flash[:alert])
  end

  test 'GET edit with unknown token redirects with alert' do
    get edit_password_reset_url('bogustoken')
    assert_redirected_to new_password_resets_url
  end

  test 'PATCH update with valid params resets password and clears token' do
    ActsAsTenant.without_tenant { @user.generate_password_reset_token! }
    patch password_reset_url(@user.password_reset_token),
          params: { user: { password: 'newpassword123', password_confirmation: 'newpassword123' } }
    assert_redirected_to new_session_url
    assert_nil @user.reload.password_reset_token
  end

  test 'PATCH update with mismatched passwords re-renders edit' do
    ActsAsTenant.without_tenant { @user.generate_password_reset_token! }
    patch password_reset_url(@user.password_reset_token),
          params: { user: { password: 'newpassword123', password_confirmation: 'wrongpassword' } }
    assert_response :unprocessable_entity
  end

  test 'PATCH update with expired token redirects' do
    @user.update_columns(
      password_reset_token: 'expiredtoken',
      password_reset_sent_at: 3.hours.ago
    )
    patch password_reset_url('expiredtoken'),
          params: { user: { password: 'newpassword123', password_confirmation: 'newpassword123' } }
    assert_redirected_to new_password_resets_url
  end
end
