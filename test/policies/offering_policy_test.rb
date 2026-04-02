require 'test_helper'

class OfferingPolicyTest < ActiveSupport::TestCase
  setup do
    ActsAsTenant.current_tenant = organizations(:one)
    @admin     = users(:admin)
    @producer  = users(:producer)
    @supporter = users(:supporter)
    @offering  = offerings(:open)
  end

  teardown { ActsAsTenant.current_tenant = nil }

  test 'admin can toggle_publish' do
    assert OfferingPolicy.new(@admin, @offering).toggle_publish?
  end

  test 'managing producer can toggle_publish' do
    assert OfferingPolicy.new(@producer, @offering).toggle_publish?
  end

  test 'supporter cannot toggle_publish' do
    assert_not OfferingPolicy.new(@supporter, @offering).toggle_publish?
  end
end
