# frozen_string_literal: true

require 'test_helper'

class HarvestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:supporter)
    log_in_as(@user)
    @harvest = harvests(:one)
    @offered_one = offered_products(:one)
    @offered_two = offered_products(:two)
  end

  def create_harvest
    Harvest.create!(
      offering: offerings(:open),
      user: @user,
    )
  end

  def valid_params(offered_product)
    { harvest: { harvested_products_attributes: [{ offered_product_id: offered_product.id, amount: 2 }] } }
  end

  def invalid_params
    { harvest: { harvested_products_attributes: [{ offered_product_id: '', amount: 2 }] } }
  end

  test 'should get new' do
    get new_harvest_url
    assert_response :success
  end

  test 'should create harvest' do
    assert_difference('Harvest.count') do
      post harvests_url, params: valid_params(@offered_one)
    end

    assert_redirected_to harvest_url(Harvest.last)
  end

  test 'should not create harvest when invalid' do
    assert_no_difference('Harvest.count') do
      post harvests_url, params: invalid_params
    end

    assert_response :unprocessable_entity
  end

  test 'should show harvest' do
    harvest = create_harvest
    get harvest_url(harvest)
    assert_response :success
  end

  test 'should get edit' do
    harvest = create_harvest
    get edit_harvest_url(harvest)
    assert_response :success
  end

  test 'should update harvest' do
    harvest = create_harvest
    patch harvest_url(harvest), params: valid_params(@offered_two)
    assert_redirected_to harvest_url(harvest)
  end

  test 'should not update harvest when invalid' do
    harvest = create_harvest
    patch harvest_url(harvest), params: invalid_params

    assert_response :unprocessable_entity
  end

  test 'supporter can cancel own harvest while offering is open' do
    harvest = create_harvest
    assert_difference('Harvest.count', -1) do
      delete harvest_url(harvest)
    end
    assert_redirected_to root_path
  end

  test 'supporter cannot cancel another users harvest' do
    other_harvest = harvests(:one) # belongs to user :one, not :supporter
    assert_no_difference('Harvest.count') do
      delete harvest_url(other_harvest)
    end
    assert_redirected_to root_path
  end

  test 'supporter cannot cancel harvest when offering is closed' do
    # harvests(:one) uses offering(:one) which is in the past
    harvest = harvests(:one)
    harvest.update_columns(user_id: @user.id)
    assert_no_difference('Harvest.count') do
      delete harvest_url(harvest)
    end
    assert_redirected_to root_path
  end

  # Harvest index (nested under offering)
  test 'admin can see harvest index for offering' do
    log_in_as(users(:admin))
    get offering_harvests_url(offerings(:open))
    assert_response :success
  end

  test 'producer can see harvest index for managed location' do
    log_in_as(users(:producer))
    get offering_harvests_url(offerings(:open))
    assert_response :success
  end

  test 'supporter cannot see harvest index' do
    get offering_harvests_url(offerings(:open))
    assert_redirected_to root_path
  end

  test 'harvest index is scoped to the offering' do
    log_in_as(users(:admin))
    get offering_harvests_url(offerings(:open))
    # The offering(:open) has no harvests; offering(:one) does — confirms scoping
    assert_select 'h1', text: /Pedidos/
    assert_match 'Nenhum pedido', response.body
  end

  # Admin full harvest CRUD
  test 'admin GET edit returns 200' do
    log_in_as(users(:admin))
    harvest = create_harvest
    get edit_harvest_url(harvest)
    assert_response :success
  end

  test 'admin PATCH update succeeds' do
    log_in_as(users(:admin))
    harvest = create_harvest
    patch harvest_url(harvest), params: valid_params(@offered_one)
    assert_redirected_to harvest_url(harvest)
  end

  test 'admin DELETE destroy succeeds' do
    log_in_as(users(:admin))
    assert_difference('Harvest.count', -1) do
      delete harvest_url(harvests(:one))
    end
    assert_redirected_to root_path
  end
end
