class AddOnlineToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :online, :boolean
  end
end
