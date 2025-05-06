class AddReferredByToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :referred_by, :string
  end
end
