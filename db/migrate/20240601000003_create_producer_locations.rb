class CreateProducerLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :producer_locations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    add_index :producer_locations, %i[user_id location_id]
  end
end
