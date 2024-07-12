require 'test_helper'

class OfferingsHelperTest < ActionView::TestCase
  setup do
    @offering = offerings(:one)
    @harvest = harvests(:one)
  end

  test '#harvest_to_string' do
    assert_equal 'Abacate (1), Laranja (2)', harvest_to_string(@harvest)
  end

  test '#total_harvested' do
    assert_equal 'Abacate (2), Laranja (4)', total_harvested(@offering)
  end
end
