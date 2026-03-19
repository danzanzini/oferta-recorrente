require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @user = users(:producer)
    log_in_as(@user)
  end

  def valid_product_params
    { product: {
      description: @product.description, main_usage: @product.main_usage, name: @product.name, organization_id: @product.organization_id
    } }
  end

  def invalid_product_params
    { product: { name: nil } }
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: valid_product_params
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should not create product when invalid" do
    assert_no_difference("Product.count") do
      post products_url, params: invalid_product_params
    end

    assert_response :unprocessable_entity
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: valid_product_params
    assert_redirected_to product_url(@product)
  end

  test "should not update product when invalid" do
    patch product_url(@product), params: invalid_product_params
    assert_response :unprocessable_entity
  end

  test "should destroy product not in active offering" do
    product = Product.create!(name: 'Deletable', organization: organizations(:one))
    assert_difference("Product.count", -1) do
      delete product_url(product)
    end
    assert_redirected_to products_url
  end

  test "should not destroy product in active offering" do
    product = Product.create!(name: 'In Active Offering', organization: organizations(:one))
    OfferedProduct.create!(
      offering: offerings(:open),
      product: product,
      amount: 5,
      organization: organizations(:one)
    )
    assert_no_difference("Product.count") do
      delete product_url(product)
    end
    assert_redirected_to products_url
  end

  test "supporter cannot destroy product" do
    log_in_as(users(:supporter))
    delete product_url(@product)
    assert_redirected_to products_url
  end
end
