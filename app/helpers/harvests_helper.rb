module HarvestsHelper
  def harvested_product(offered_product, current_user)
    return HarvestedProduct.new(offered_product_id: offered_product.id) if action_name == 'new'

    offered_product.harvested_products.from_user(current_user) ||
      HarvestedProduct.new(offered_product_id: offered_product.id)
  end
end
