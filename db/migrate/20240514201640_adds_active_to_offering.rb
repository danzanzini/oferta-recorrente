class AddsActiveToOffering < ActiveRecord::Migration[7.1]
  def change
    add_column(:offerings, :active, :boolean, default: true, null: false)
  end
end
