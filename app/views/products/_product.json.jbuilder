json.extract! product, :id, :name, :description, :main_usage, :organization_id, :created_at, :updated_at
json.url product_url(product, format: :json)
