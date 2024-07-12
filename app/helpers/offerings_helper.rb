module OfferingsHelper
  def harvest_to_string(harvest)
    harvest.harvested_products.map { |hp| to_string(hp) }.join(', ')
  end

  def total_harvested(offering)
    offering.total_harvested.map do |k, v|
      "#{k} (#{v})"
    end.join(', ')
  end

  private

  def to_string(harvested_product)
    "#{harvested_product.product_name} (#{harvested_product.amount})"
  end
end
