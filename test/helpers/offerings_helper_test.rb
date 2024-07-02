require 'test_helper'

class OfferingsHelperTest < ActionView::TestCase
  setup do
    @harvest = harvests(:one)
    @harvest.harvested_products.append(harvested_products(:two))
  end

  test '#harvest_to_string' do
    assert_equal harvest_to_string(@harvest), 'Abacate (1), Laranja (2)'
  end
end
