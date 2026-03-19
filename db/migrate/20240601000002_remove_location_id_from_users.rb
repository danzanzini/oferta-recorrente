class RemoveLocationIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :location_id, :bigint
  end
end
