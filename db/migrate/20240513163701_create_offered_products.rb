class CreateOfferedProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :offered_products do |t|
      t.references :offering, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
