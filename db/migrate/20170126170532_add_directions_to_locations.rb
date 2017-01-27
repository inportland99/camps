class AddDirectionsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :directions, :text
  end
end
