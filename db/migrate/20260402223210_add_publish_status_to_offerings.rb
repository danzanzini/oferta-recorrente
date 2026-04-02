class AddPublishStatusToOfferings < ActiveRecord::Migration[7.1]
  def change
    add_column :offerings, :publish_status, :integer, default: 0, null: false
  end
end
