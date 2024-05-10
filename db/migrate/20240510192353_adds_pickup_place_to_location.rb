class AddsPickupPlaceToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column(:locations, :pickup_place, :string)
  end
end
