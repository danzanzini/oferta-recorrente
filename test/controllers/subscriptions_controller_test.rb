require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @supporter = users(:supporter)
    log_in_as(@admin)
  end

  test 'admin can get new subscription form' do
    get new_user_subscription_url(@supporter)
    assert_response :success
  end

  test 'admin can create subscription' do
    user_without_sub = users(:one)
    user_without_sub.subscription&.destroy

    assert_difference('Subscription.count') do
      post user_subscriptions_url(user_without_sub), params: {
        subscription: { item_limit: 5, location_id: locations(:one).id, active: true }
      }
    end
    assert_redirected_to user_path(user_without_sub)
  end

  test 'admin can edit subscription' do
    get edit_user_subscription_url(@supporter, subscriptions(:supporter))
    assert_response :success
  end

  test 'admin can update subscription' do
    patch user_subscription_url(@supporter, subscriptions(:supporter)), params: {
      subscription: { item_limit: 10 }
    }
    assert_redirected_to user_path(@supporter)
    assert_equal 10, subscriptions(:supporter).reload.item_limit
  end

  test 'non-admin cannot access subscription management' do
    log_in_as(@supporter)
    get new_user_subscription_url(@supporter)
    assert_redirected_to root_path
  end
end
