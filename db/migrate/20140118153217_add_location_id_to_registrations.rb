class AddLocationIdToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :location_id, :integer
  end
end
