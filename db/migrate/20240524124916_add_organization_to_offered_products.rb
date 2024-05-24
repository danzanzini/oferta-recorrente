class AddOrganizationToOfferedProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :offered_products, :organization, null: false, foreign_key: true
  end
end
