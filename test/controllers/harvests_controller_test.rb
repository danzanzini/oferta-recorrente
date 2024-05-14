require "test_helper"

class HarvestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @harvest = harvests(:one)
  end

  test "should get index" do
    get harvests_url
    assert_response :success
  end

  test "should get new" do
    get new_harvest_url
    assert_response :success
  end

  test "should create harvest" do
    assert_difference("Harvest.count") do
      post harvests_url, params: { harvest: { offering_id: @harvest.offering_id, user_id: @harvest.user_id } }
    end

    assert_redirected_to harvest_url(Harvest.last)
  end

  test "should show harvest" do
    get harvest_url(@harvest)
    assert_response :success
  end

  test "should get edit" do
    get edit_harvest_url(@harvest)
    assert_response :success
  end

  test "should update harvest" do
    patch harvest_url(@harvest), params: { harvest: { offering_id: @harvest.offering_id, user_id: @harvest.user_id } }
    assert_redirected_to harvest_url(@harvest)
  end

  test "should destroy harvest" do
    assert_difference("Harvest.count", -1) do
      delete harvest_url(@harvest)
    end

    assert_redirected_to harvests_url
  end
end
