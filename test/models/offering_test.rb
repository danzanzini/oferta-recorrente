# frozen_string_literal: true

require 'test_helper'

class OfferingTest < ActiveSupport::TestCase
  setup do
    @offering = offerings(:one)
  end

  test 'its open at a given time' do
    now = Time.now
    @offering.opens_at = now - 1.hour
    @offering.closes_at = now + 1.hour
    assert @offering.is_open?(now)
  end

  test 'its closed at a given time' do
    now = Time.now
    @offering.opens_at = now + 1.hour
    assert !@offering.is_open?(now)
  end
end
