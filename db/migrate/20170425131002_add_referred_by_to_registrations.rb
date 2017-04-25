class AddReferredByToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :referred_by, :string
  end
end
