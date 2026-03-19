require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  setup do
    ActsAsTenant.current_tenant = organizations(:one)
    @admin = users(:admin)
    @producer = users(:producer)
    @supporter = users(:supporter)
    @target = users(:supporter)
  end

  teardown do
    ActsAsTenant.current_tenant = nil
  end

  test 'admin can toggle_active' do
    assert UserPolicy.new(@admin, @target).toggle_active?
  end

  test 'producer cannot toggle_active' do
    assert_not UserPolicy.new(@producer, @target).toggle_active?
  end

  test 'supporter cannot toggle_active' do
    assert_not UserPolicy.new(@supporter, @target).toggle_active?
  end
end
