require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  setup do
    @location = locations(:one)
  end

  test "current_offering returns the last open offering" do
    mock_offerings = Minitest::Mock.new
    mock_offerings.expect :open_now, [:expected_offering]

    @location.stub :offerings, mock_offerings do
      assert_equal :expected_offering, @location.current_offering
    end

    mock_offerings.verify
  end

  test "current_offering returns nil when no offerings are open" do
    mock_offerings = Minitest::Mock.new
    mock_offerings.expect :open_now, []

    @location.stub :offerings, mock_offerings do
      assert_nil @location.current_offering
    end

    mock_offerings.verify
  end
end
