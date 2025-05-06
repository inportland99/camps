class AddActiveToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :active, :boolean, default: false
  end
end
