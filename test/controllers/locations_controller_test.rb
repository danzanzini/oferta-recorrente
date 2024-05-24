# frozen_string_literal: true

require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location = locations(:one)
    @user = users(:admin)
    log_in_as(@user)
  end

  def valid_location_params
    { location: { address: @location.address, link: @location.link, name: @location.name,
                  organization_id: @location.organization_id, pickup_place: @location.pickup_place } }
  end

  def invalid_location_params
    { location: { name: nil } }
  end

  test 'should get index' do
    get locations_url
    assert_response :success
  end

  test 'should get new' do
    get new_location_url
    assert_response :success
  end

  test 'should create location' do
    assert_difference('Location.count') do
      post locations_url, params: valid_location_params
    end

    assert_redirected_to location_url(Location.last)
  end

  test 'should not create location when invalid' do
    assert_no_difference('Location.count') do
      post locations_url, params: invalid_location_params
    end

    assert_response :unprocessable_entity
  end

  test 'should show location' do
    get location_url(@location)
    assert_response :success
  end

  test 'should get edit' do
    get edit_location_url(@location)
    assert_response :success
  end

  test 'should update location' do
    patch location_url(@location), params: valid_location_params
    assert_redirected_to location_url(@location)
  end

  test 'should not update location' do
    patch location_url(@location), params: invalid_location_params
    assert_response :unprocessable_entity
  end


  test 'should deactivate location' do
    delete location_url(@location)
    assert !@location.reload.active
    assert_redirected_to locations_url
  end
end
