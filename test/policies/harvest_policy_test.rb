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

  test 'destroy?: supporter can destroy own harvest on open offering' do
    open_harvest = Harvest.new(offering: offerings(:open), user: @supporter)
    assert HarvestPolicy.new(@supporter, open_harvest).destroy?
  end

  test 'destroy?: supporter cannot destroy when offering is closed' do
    closed_harvest = Harvest.new(offering: offerings(:closed_past), user: @supporter)
    assert_not HarvestPolicy.new(@supporter, closed_harvest).destroy?
  end

  test 'destroy?: supporter cannot destroy another users harvest' do
    other_harvest = Harvest.new(offering: offerings(:open), user: @admin)
    assert_not HarvestPolicy.new(@supporter, other_harvest).destroy?
  end

  test 'destroy?: admin can destroy open offering harvest' do
    open_harvest = Harvest.new(offering: offerings(:open), user: @supporter)
    assert HarvestPolicy.new(@admin, open_harvest).destroy?
  end

  test 'update?: admin can update any harvest' do
    assert HarvestPolicy.new(@admin, @harvest).update?
  end

  test 'destroy?: admin can destroy any harvest including on closed offering' do
    closed_harvest = Harvest.new(offering: offerings(:closed_past), user: @supporter)
    assert HarvestPolicy.new(@admin, closed_harvest).destroy?
  end
end
