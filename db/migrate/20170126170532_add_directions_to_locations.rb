class AddDirectionsToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :directions, :text
  end
end
