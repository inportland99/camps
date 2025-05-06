class AddParentInfoToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :parent_city, :string
    add_column :registrations, :parent_state, :string
    add_column :registrations, :parent_zip, :integer
  end
end
