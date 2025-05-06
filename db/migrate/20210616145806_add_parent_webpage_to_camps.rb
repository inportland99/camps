class AddParentWebpageToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :parent_webpage, :string
  end
end
