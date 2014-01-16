class AddTotalToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :total, :integer
  end
end
