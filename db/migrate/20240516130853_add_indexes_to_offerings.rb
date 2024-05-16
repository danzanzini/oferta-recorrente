# frozen_string_literal: true

class AddIndexesToOfferings < ActiveRecord::Migration[7.1]
  def change
    add_index :offerings, :closes_at
    add_index :offerings, :opens_at
  end
end
