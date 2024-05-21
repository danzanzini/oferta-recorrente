# frozen_string_literal: true

require 'test_helper'

class HarvestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:supporter)
    log_in_as(@user)
    @harvest = harvests(:one)
    @offered_product = offered_products(:one)
  end

  test 'should get new' do
    get new_harvest_url
    assert_response :success
  end

  test 'should create harvest' do
    assert_difference('Harvest.count') do
      post harvests_url,
           params: { harvest: { harvested_products_attributes: [{ offered_product_id: @offered_product.id, amount: 2 }] } }
    end

    assert_redirected_to harvest_url(Harvest.last)
  end

  test 'should show harvest' do
    get harvest_url(@harvest)
    assert_response :success
  end

  test 'should get edit' do
    get edit_harvest_url(@harvest)
    assert_response :success
  end

  test 'should update harvest' do
    patch harvest_url(@harvest),
          params: { harvest: { harvested_products_attributes: [{ offered_product_id: @offered_product.id, amount: 2 }] } }
    assert_redirected_to harvest_url(@harvest)
  end
end
