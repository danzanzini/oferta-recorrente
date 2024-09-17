require 'test_helper'

class PagesHelperTest < ActionView::TestCase
  setup do
    @harvest = harvests(:one)
  end
  test '#current_harvest_path returns a new harvest link if one does not exist' do
    assert current_harvest_path(nil), new_harvest_path
  end

  test '#current_harvest_path returns a edit harvest link if one does exist' do
    assert current_harvest_path(@harvest), edit_harvest_path(@harvest)
  end

  test '#current_harvest_call_to_action returns a new harvest call to action if one does not exist' do
    assert current_harvest_call_to_action(nil), 'Realizar pedido'
  end

  test '#current_harvest_call_to_action returns a edit harvest call to action if one does exist' do
    assert current_harvest_call_to_action(@harvest), 'Editar pedido realizado'
  end
end
