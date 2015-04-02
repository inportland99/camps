class AddShowDescriptionToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :show_description, :text
  end
end
