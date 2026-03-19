require 'test_helper'

class HarvestPolicyTest < ActiveSupport::TestCase
  setup do
    ActsAsTenant.current_tenant = organizations(:one)
    @harvest = harvests(:one)
    @admin = users(:admin)
    @producer = users(:producer)
    @supporter = users(:supporter)
  end

  teardown do
    ActsAsTenant.current_tenant = nil
  end

  test 'admin can show harvest' do
    assert HarvestPolicy.new(@admin, @harvest).show?
  end

  test 'producer can show harvest' do
    assert HarvestPolicy.new(@producer, @harvest).show?
  end

  test 'supporter can show own harvest' do
    assert HarvestPolicy.new(@supporter, @harvest).show?
  end

  test 'admin can index harvests' do
    assert HarvestPolicy.new(@admin, Harvest).index?
  end

  test 'producer can index harvests' do
    assert HarvestPolicy.new(@producer, Harvest).index?
  end

  test 'supporter cannot index harvests' do
    assert_not HarvestPolicy.new(@supporter, Harvest).index?
  end
end
