module PagesHelper
  def current_harvest_path(harvest)
    if harvest
      edit_harvest_path(harvest.id)
    else
      new_harvest_path
    end
  end

  def current_harvest_call_to_action(harvest)
    if harvest
      'Editar pedido realizado'
    else
      'Realizar pedido'
    end
  end
end
