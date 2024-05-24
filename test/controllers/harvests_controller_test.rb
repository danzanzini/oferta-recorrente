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
end
