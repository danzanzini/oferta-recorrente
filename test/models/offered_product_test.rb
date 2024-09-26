require 'test_helper'

class OfferedProductTest < ActiveSupport::TestCase
  setup do
    @offered_product = offered_products(:one)
    @harvested_products = @offered_product.harvested_products
    @harvested_products_sum = @harvested_products.sum(:amount)
  end

  test 'available_amount' do
    assert_equal(
      @offered_product.amount - @harvested_products_sum,
      @offered_product.available_amount
    )
  end

  test 'available_amount with no harvested products' do
    @offered_product.harvested_products.destroy_all
    assert_equal(
      @offered_product.amount,
      @offered_product.available_amount
    )
  end
end
