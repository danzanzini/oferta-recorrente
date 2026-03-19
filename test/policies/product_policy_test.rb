require 'test_helper'

class ProductPolicyTest < ActiveSupport::TestCase
  setup do
    ActsAsTenant.current_tenant = organizations(:one)
    @admin = users(:admin)
    @producer = users(:producer)
    @supporter = users(:supporter)
    @product = products(:one)
  end

  teardown do
    ActsAsTenant.current_tenant = nil
  end

  test 'admin can destroy product not in active offering' do
    # products(:one) is in offerings(:one) which has active=true BUT
    # it uses fixed past dates so open_now would not include it.
    # We need a product that has NO offered_products in active offerings.
    product = Product.create!(name: 'Test Product', organization: organizations(:one))
    assert ProductPolicy.new(@admin, product).destroy?
  end

  test 'producer can destroy product not in active offering' do
    product = Product.create!(name: 'Test Product 2', organization: organizations(:one))
    assert ProductPolicy.new(@producer, product).destroy?
  end

  test 'admin cannot destroy product in active offering' do
    # offerings(:open) is currently open and active=true
    # We need a product with an offered_product in an active offering
    product = Product.create!(name: 'Test Product 3', organization: organizations(:one))
    OfferedProduct.create!(
      offering: offerings(:open),
      product: product,
      amount: 10,
      organization: organizations(:one)
    )
    assert_not ProductPolicy.new(@admin, product).destroy?
  end

  test 'supporter cannot destroy product' do
    assert_not ProductPolicy.new(@supporter, @product).destroy?
  end
end
