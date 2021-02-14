class AddActiveToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :active, :boolean, default: false
  end
end
