require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  setup do
    ActsAsTenant.current_tenant = organizations(:one)
    @user = users(:one)
    @location = locations(:one)
  end

  teardown do
    ActsAsTenant.current_tenant = nil
  end

  test 'is valid with valid attributes' do
    # Use admin (has no subscription) to avoid uniqueness conflict
    sub = Subscription.new(user: users(:admin), location: @location, item_limit: 8)
    sub.organization = organizations(:one)
    assert sub.valid?
  end

  test 'requires item_limit' do
    sub = Subscription.new(user: @user, location: @location, item_limit: nil)
    sub.organization = organizations(:one)
    assert_not sub.valid?
    assert_includes sub.errors[:item_limit], "can't be blank"
  end

  test 'item_limit must be greater than 0' do
    sub = Subscription.new(user: @user, location: @location, item_limit: 0)
    sub.organization = organizations(:one)
    assert_not sub.valid?
    assert sub.errors[:item_limit].any?
  end

  test 'prevents two active subscriptions for the same user' do
    existing = subscriptions(:one)
    assert existing.active

    sub = Subscription.new(user: @user, location: @location, item_limit: 5, active: true)
    sub.organization = organizations(:one)
    assert_not sub.valid?
    assert sub.errors[:base].any?
  end

  test 'allows inactive subscription when active one exists' do
    sub = Subscription.new(user: @user, location: @location, item_limit: 5, active: false)
    sub.organization = organizations(:one)
    assert sub.valid?
  end
end
