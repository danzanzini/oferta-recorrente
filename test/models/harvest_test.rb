require 'test_helper'

class HarvestTest < ActiveSupport::TestCase
  setup do
    ActsAsTenant.current_tenant = organizations(:one)
    @offering = offerings(:open)
    @user = users(:supporter)
    @offered_product = offered_products(:one)
  end

  teardown do
    ActsAsTenant.current_tenant = nil
  end

  test 'is valid without subscription (no item limit enforced)' do
    harvest = Harvest.new(offering: @offering, user: users(:admin))
    assert harvest.valid?
  end

  test 'passes when total items within subscription limit' do
    harvest = Harvest.new(offering: @offering, user: @user)
    harvest.harvested_products.build(offered_product: @offered_product, amount: 6) # limit is 6
    assert harvest.valid?
  end

  test 'fails when total items exceed subscription limit' do
    harvest = Harvest.new(offering: @offering, user: @user)
    harvest.harvested_products.build(offered_product: @offered_product, amount: 7) # limit is 6
    assert_not harvest.valid?
    assert harvest.errors[:base].any?
  end

  test 'total_items excludes marked for destruction' do
    harvest = Harvest.new(offering: @offering, user: @user)
    hp = harvest.harvested_products.build(offered_product: @offered_product, amount: 5)
    hp.mark_for_destruction
    assert_equal 0, harvest.total_items
  end
end
