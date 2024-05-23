# frozen_string_literal: true

require 'test_helper'

class OfferingTest < ActiveSupport::TestCase
  setup do
    @offering = offerings(:one)
  end

  test 'scope open_now returns only offerings that are currently open' do
    assert_includes Offering.open_now, offerings(:open)
    assert_not_includes Offering.open_now, offerings(:closed_past)
    assert_not_includes Offering.open_now, offerings(:closed_future)
  end

  test 'its open at a given time' do
    now = Time.now
    @offering.opens_at = now - 1.hour
    @offering.closes_at = now + 1.hour
    assert @offering.open?(now)
  end

  test 'its closed at a given time' do
    now = Time.now
    @offering.opens_at = now + 1.hour
    assert !@offering.open?(now)
  end

  test '#before_opening?' do
    @offering.opens_at = Time.now + 1.hour

    assert @offering.before_opening?
  end

  test 'it is invalid if closes before opens_at' do
    @offering.closes_at = @offering.opens_at - 1.hour

    assert_not @offering.valid?
    assert_includes @offering.errors[:closes_at], "Must be after opens_at"
  end
end
