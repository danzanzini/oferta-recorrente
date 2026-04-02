# frozen_string_literal: true

class ChangePublishStatusToString < ActiveRecord::Migration[7.1]
  INT_TO_STRING = { 0 => 'scheduled', 1 => 'open', 2 => 'closed', 3 => 'unpublished' }.freeze

  def up
    add_column :offerings, :publish_status_str, :string, null: false, default: 'scheduled'

    INT_TO_STRING.each do |int_val, str_val|
      execute "UPDATE offerings SET publish_status_str = '#{str_val}' WHERE publish_status = #{int_val}"
    end

    remove_column :offerings, :publish_status
    rename_column :offerings, :publish_status_str, :publish_status
  end

  def down
    add_column :offerings, :publish_status_int, :integer, null: false, default: 0

    INT_TO_STRING.each do |int_val, str_val|
      execute "UPDATE offerings SET publish_status_int = #{int_val} WHERE publish_status = '#{str_val}'"
    end

    remove_column :offerings, :publish_status
    rename_column :offerings, :publish_status_int, :publish_status
  end
end
