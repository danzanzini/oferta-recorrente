class AddOrganizationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :organization, index: true
  end
end
