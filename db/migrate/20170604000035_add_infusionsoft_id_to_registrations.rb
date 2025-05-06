class AddInfusionsoftIdToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :infusionsoft_id, :integer
  end
end
