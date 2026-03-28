require "test_helper"

class LayoutTest < ActionDispatch::IntegrationTest
  test "body has white background" do
    log_in_as(users(:admin))
    get root_url
    assert_select "body[class*='bg-white']"
    assert_no_match "bg-neutral-2", response.body
  end

  test "logged out user sees only logo in header" do
    get new_session_url
    assert_match "CSA Recife", response.body
    assert_no_match "Gerenciar", response.body
    assert_no_match "Minhas Oferendas", response.body
    assert_no_match "Logout", response.body
  end

  test "logged in user sees full nav" do
    log_in_as(users(:admin))
    get root_url
    assert_match "Gerenciar", response.body
    assert_match "Minhas Oferendas", response.body
    assert_match "Logout", response.body
  end

  test "main element does not have excessive top margin" do
    log_in_as(users(:admin))
    get root_url
    assert_no_match "mt-28", response.body
  end

  test "main element does not have container class" do
    log_in_as(users(:admin))
    get root_url
    assert_select "main:not([class*='container'])"
  end
end
