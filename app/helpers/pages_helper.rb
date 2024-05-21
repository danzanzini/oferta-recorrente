module PagesHelper
  def harvest_link(harvest)
    if harvest
      link_to(edit_harvest_path(harvest.id)) { 'Edit the weekly harvest' }
    else
      link_to(new_harvest_path) { 'Create new harvest' }
    end
  end
end
