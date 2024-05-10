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

  test "should scope posts to the current tenant" do
    ActsAsTenant.current_tenant = @org_one
    assert_equal 1, User.count
    assert_equal @org_one.id, User.first.organization_id

    ActsAsTenant.current_tenant = @org_two
    assert_equal 1, User.count
    assert_equal @org_two.id, User.first.organization_id
  end

  test 'full name' do
    @user.first_name = 'Valter'
    @user.last_name = 'França'
    assert_equal @user.name, 'Valter França'
  end
end
