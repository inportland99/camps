class AddShowDescriptionToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :show_description, :text
  end
end
