class AddTotalToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :total, :integer
  end
end
