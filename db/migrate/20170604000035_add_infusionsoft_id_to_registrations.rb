class AddInfusionsoftIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :infusionsoft_id, :integer
  end
end
