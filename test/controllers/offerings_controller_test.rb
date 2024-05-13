require "test_helper"

class OfferingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offering = offerings(:one)
    log_in_as(users(:one))
  end

  test "should get index" do
    get offerings_url
    assert_response :success
  end

  test "should get new" do
    get new_offering_url
    assert_response :success
  end

  test "should create offering" do
    assert_difference("Offering.count") do
      post offerings_url, params: { offering: { closes_at: @offering.closes_at, harvest_at: @offering.harvest_at, location_id: @offering.location_id, opens_at: @offering.opens_at, organization_id: @offering.organization_id } }
    end

    assert_redirected_to offering_url(Offering.last)
  end

  test "should show offering" do
    get offering_url(@offering)
    assert_response :success
  end

  test "should get edit" do
    get edit_offering_url(@offering)
    assert_response :success
  end

  test "should update offering" do
    patch offering_url(@offering), params: { offering: { closes_at: @offering.closes_at, harvest_at: @offering.harvest_at, location_id: @offering.location_id, opens_at: @offering.opens_at, organization_id: @offering.organization_id } }
    assert_redirected_to offering_url(@offering)
  end

  test "should destroy offering" do
    assert_difference("Offering.count", -1) do
      delete offering_url(@offering)
    end

    assert_redirected_to offerings_url
  end
end
