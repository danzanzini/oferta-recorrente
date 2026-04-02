# frozen_string_literal: true

require 'test_helper'

class OfferingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offering = offerings(:not_open_yet)
    log_in_as(users(:admin))

    def valid_offering_params
      { offering: {
        opens_at: Time.now + 1.hour,
        closes_at: Time.now + 12.hour,
        harvest_at: @offering.harvest_at,
        location_id: @offering.location_id,
        offered_products_attributes: [{ product_id: products(:one).id, amount: 30 }]
      } }
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

  test 'new with from_id responds successfully' do
    source = offerings(:one) # has offered_products(:one)
    get new_offering_url(from_id: source.id)
    assert_response :success
  end

  test 'producer scoped to managed locations sees only those offerings' do
    log_in_as(users(:producer))
    get offerings_url
    assert_response :success
  end

  # Publish workflow
  test 'admin can toggle_publish: scheduled → open' do
    offering = offerings(:not_open_yet)
    assert offering.scheduled?
    post toggle_publish_offering_url(offering)
    assert offering.reload.open?
    assert_redirected_to offering_url(offering)
  end

  test 'admin can toggle_publish: open → unpublished' do
    offering = offerings(:open)
    assert offering.open?
    post toggle_publish_offering_url(offering)
    assert offering.reload.unpublished?
    assert_redirected_to offering_url(offering)
  end

  test 'admin can toggle_publish: unpublished → scheduled' do
    offering = offerings(:not_open_yet)
    offering.update_columns(publish_status: Offering.publish_statuses[:unpublished])
    post toggle_publish_offering_url(offering)
    assert offering.reload.scheduled?
    assert_redirected_to offering_url(offering)
  end

  test 'supporter cannot toggle_publish' do
    log_in_as(users(:supporter))
    post toggle_publish_offering_url(offerings(:open))
    assert_redirected_to root_path
  end

  # Print view
  test 'print renders with print layout (no nav)' do
    get print_offering_url(offerings(:open))
    assert_response :success
    assert_select 'nav', count: 0
    assert_select 'header', count: 0
  end

  test 'print renders a table of harvests' do
    get print_offering_url(offerings(:open))
    assert_response :success
    assert_select 'table'
  end

  test 'print includes window.print()' do
    get print_offering_url(offerings(:open))
    assert_match 'window.print()', response.body
  end

  test 'supporter cannot access print page' do
    log_in_as(users(:supporter))
    get print_offering_url(offerings(:open))
    assert_redirected_to root_path
  end
end
