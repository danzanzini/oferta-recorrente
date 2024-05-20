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
end
