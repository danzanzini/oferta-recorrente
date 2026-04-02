require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    ActsAsTenant.current_tenant = organizations(:one)
    @user = users(:one)
    @user.password_reset_token = 'abc123testtoken'
    @user.password_reset_sent_at = Time.zone.now
  end

  teardown { ActsAsTenant.current_tenant = nil }

  test 'password_reset email goes to user email' do
    mail = UserMailer.password_reset(@user)
    assert_equal [@user.email], mail.to
  end

  test 'password_reset email has subject' do
    mail = UserMailer.password_reset(@user)
    assert_match(/Redefinição de senha/, mail.subject)
  end

  test 'password_reset email body contains the token' do
    mail = UserMailer.password_reset(@user)
    assert_match('abc123testtoken', mail.body.encoded)
  end
end
