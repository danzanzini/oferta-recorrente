class CreateHarvestedProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :harvested_products do |t|
      t.integer :amount
      t.references :harvest, null: false, foreign_key: true
      t.references :offered_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
