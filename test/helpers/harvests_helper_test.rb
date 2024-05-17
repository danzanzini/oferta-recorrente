require 'test_helper'

class HarvestsHelperTest < ActionView::TestCase
  setup do
    @offered_product = offered_products(:one)
    @user = users(:one)
  end

  test 'returns a new instance if in new action' do
    def action_name
      'new'
    end

    object = harvested_product(@offered_product, @user)
    assert !object.persisted?
  end

  test 'returns existing instance' do
    def action_name
      'edit'
    end

    @harvested_product = harvested_products(:one)

    object = harvested_product(@offered_product, @user)
    assert_equal object, @harvested_product
  end
end
