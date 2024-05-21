require 'test_helper'

class PagesHelperTest < ActionView::TestCase
  setup do
    @harvest = harvests(:one)
  end
  test '#harvest_link returns a new harvest link if one does not exist' do
    assert_includes harvest_link(nil), 'Create new harvest'
  end

  test '#harvest_link returns a edit harvest link if one does exist' do
    assert_includes harvest_link(@harvest), 'Edit the weekly harvest'
  end
end
