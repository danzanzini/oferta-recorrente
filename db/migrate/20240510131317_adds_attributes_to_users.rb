class AddsAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.column(:first_name, :string)
      t.column(:last_name, :string)
      t.column(:active, :boolean, default: true, null: false)
      t.column(:role, :integer, default: 0, null: false)
    end
  end
end
