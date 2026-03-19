class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.integer :item_limit, null: false
      t.boolean :active, default: true, null: false
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
