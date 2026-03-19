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

  test 'it is invalid if it overlaps another active offering at the same location' do
    ActsAsTenant.current_tenant = organizations(:one)
    overlapping = Offering.new(
      location: locations(:one),
      opens_at: 1.hour.ago,
      closes_at: 1.hour.from_now
    )
    overlapping.organization = organizations(:one)

    assert_not overlapping.valid?
    assert overlapping.errors[:base].any?
  ensure
    ActsAsTenant.current_tenant = nil
  end

  test 'it is valid if it does not overlap existing offerings at the same location' do
    ActsAsTenant.current_tenant = organizations(:one)
    non_overlapping = Offering.new(
      location: locations(:one),
      opens_at: 5.days.from_now,
      closes_at: 6.days.from_now
    )
    non_overlapping.organization = organizations(:one)

    # Validate only the overlap rule (may have other errors in test env)
    non_overlapping.valid?
    assert_not non_overlapping.errors[:base].any?
  ensure
    ActsAsTenant.current_tenant = nil
  end

  test 'overlap check allows same offering to be updated (does not conflict with itself)' do
    ActsAsTenant.current_tenant = organizations(:one)
    offering = offerings(:open)
    offering.closes_at = 2.hours.from_now

    offering.valid?
    assert_not offering.errors[:base].any?
  ensure
    ActsAsTenant.current_tenant = nil
  end
end
