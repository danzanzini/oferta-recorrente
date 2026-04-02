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
    assert @offering.open_at?(now)
  end

  test 'its closed at a given time' do
    now = Time.now
    @offering.opens_at = now + 1.hour
    assert !@offering.open_at?(now)
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

  test '#status returns Aberta for an open offering' do
    assert_equal 'Aberta', offerings(:open).status
  end

  test '#status returns Encerrada for a past offering' do
    assert_equal 'Encerrada', offerings(:closed_past).status
  end

  test '#status returns Agendada for a future offering' do
    assert_equal 'Agendada', offerings(:closed_future).status
  end

  # Publish workflow
  test 'new offering defaults to scheduled publish_status' do
    ActsAsTenant.current_tenant = organizations(:one)
    offering = Offering.new(opens_at: 1.day.from_now, closes_at: 2.days.from_now,
                            location: locations(:one), organization: organizations(:one))
    assert offering.scheduled?
  ensure
    ActsAsTenant.current_tenant = nil
  end

  test 'visible_to_supporters includes open-status offering' do
    assert_includes Offering.visible_to_supporters, offerings(:open)
  end

  test 'visible_to_supporters excludes future scheduled offering' do
    assert_not_includes Offering.visible_to_supporters, offerings(:closed_future)
  end

  test 'visible_to_supporters includes manually open offering before opens_at' do
    assert_includes Offering.visible_to_supporters, offerings(:published_future)
  end

  test 'visible_to_supporters excludes unpublished offering even if time window is active' do
    open_offering = offerings(:open)
    open_offering.update_columns(publish_status: Offering.publish_statuses[:unpublished])
    assert_not_includes Offering.visible_to_supporters, open_offering
  end

  test 'visible_to_supporters excludes closed offering' do
    assert_not_includes Offering.visible_to_supporters, offerings(:closed_past)
  end

  test '#status returns Aberta when publish_status is open' do
    offering = offerings(:open)
    assert_equal 'Aberta', offering.status
  end

  test '#status returns Despublicada when unpublished' do
    offering = offerings(:open)
    offering.publish_status = :unpublished
    assert_equal 'Despublicada', offering.status
  end

  test '#transition_status! moves scheduled offering to open when opens_at reached' do
    ActsAsTenant.current_tenant = organizations(:one)
    offering = offerings(:not_open_yet)
    offering.update_columns(opens_at: 1.hour.ago, closes_at: 1.hour.from_now)
    assert offering.scheduled?
    offering.transition_status!
    assert offering.reload.open?
  ensure
    ActsAsTenant.current_tenant = nil
  end

  test '#transition_status! moves open offering to closed when closes_at passed' do
    ActsAsTenant.current_tenant = organizations(:one)
    offering = offerings(:open)
    offering.update_columns(closes_at: 1.hour.ago)
    offering.transition_status!
    assert offering.reload.closed?
  ensure
    ActsAsTenant.current_tenant = nil
  end

  test '#transition_status! does not change unpublished offering' do
    ActsAsTenant.current_tenant = organizations(:one)
    offering = offerings(:open)
    offering.update_columns(publish_status: Offering.publish_statuses[:unpublished],
                            closes_at: 1.hour.ago)
    offering.transition_status!
    assert offering.reload.unpublished?
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
