class AddOnlineToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :online, :boolean
  end
end
