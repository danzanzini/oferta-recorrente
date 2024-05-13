class CreateOfferings < ActiveRecord::Migration[7.1]
  def change
    create_table :offerings do |t|
      t.datetime :opens_at
      t.datetime :closes_at
      t.date :harvest_at
      t.belongs_to :location, null: false, foreign_key: true
      t.belongs_to :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
