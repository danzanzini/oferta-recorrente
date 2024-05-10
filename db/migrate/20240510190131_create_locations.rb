class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :link
      t.string :address
      t.belongs_to :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
