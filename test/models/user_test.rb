require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @org_one = organizations(:one)
    @org_two = organizations(:two)
    @user = users(:one)
  end

  teardown do
    ActsAsTenant.current_tenant = nil
  end

  test "should scope users to the current tenant" do
    ActsAsTenant.current_tenant = @org_one
    assert_includes(User.all, users(:one))
    assert_not_includes(User.all, users(:two))
    assert_equal @org_one.id, User.first.organization_id

    ActsAsTenant.current_tenant = @org_two
    assert_includes(User.all, users(:two))
    assert_not_includes(User.all, users(:one))
    assert_equal @org_two.id, User.first.organization_id
  end

  test '#full_name' do
    @user.first_name = 'Valter'
    @user.last_name = 'França'
    assert_equal @user.name, 'Valter França'
  end

  test "#toggle_active!" do
    @user.toggle_active!
    assert !@user.active

    @user.toggle_active!
    assert @user.active
  end

  test '#generate_password_reset_token! sets token and sent_at' do
    ActsAsTenant.current_tenant = @org_one
    @user.generate_password_reset_token!
    assert_not_nil @user.password_reset_token
    assert_not_nil @user.password_reset_sent_at
    assert @user.password_reset_token.length > 10
  end

  test '#password_reset_expired? returns true after 2 hours' do
    @user.password_reset_sent_at = 2.hours.ago - 1.second
    assert @user.password_reset_expired?
  end

  test '#password_reset_expired? returns false within 2 hours' do
    @user.password_reset_sent_at = 1.hour.ago
    assert_not @user.password_reset_expired?
  end
end
