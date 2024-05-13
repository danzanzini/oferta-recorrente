class AddsActiveToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column(:locations, :active, :boolean, default: true)
  end
end
