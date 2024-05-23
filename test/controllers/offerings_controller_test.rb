# frozen_string_literal: true

require 'test_helper'

class OfferingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offering = offerings(:not_open_yet)
    log_in_as(users(:admin))

    def valid_offering_params
      { offering: { closes_at: @offering.closes_at, harvest_at: @offering.harvest_at, location_id: @offering.location_id,
                    opens_at: @offering.opens_at } }
    end

    def invalid_offering_params
      { offering: { closes_at: Time.now - 1.hour, opens_at: Time.now } }
    end
  end

  test 'should get index' do
    get offerings_url
    assert_response :success
  end

  test 'should get new' do
    get new_offering_url
    assert_response :success
  end

  test 'should create offering' do
    assert_difference('Offering.count') do
      post offerings_url, params: valid_offering_params
    end

    assert_redirected_to offering_url(Offering.last)
  end

  test 'should not create offering when invalid' do
    assert_no_difference('Offering.count') do
      post offerings_url, params: invalid_offering_params
    end

    assert_response :unprocessable_entity
  end

  test 'should show offering' do
    get offering_url(@offering)
    assert_response :success
  end

  test 'should get edit' do
    get edit_offering_url(@offering)
    assert_response :success
  end

  test 'should update offering' do
    patch offering_url(@offering), params: valid_offering_params
    assert_redirected_to offering_url(@offering)
  end

  test 'should not update offering when invalid' do
    patch offering_url(@offering), params: invalid_offering_params
    assert_response :unprocessable_entity
  end

  test 'should destroy offering' do
    delete offering_url(@offering)
    assert !@offering.reload.active
    assert_redirected_to offerings_url
  end
end
