class AddParentWebpageToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :parent_webpage, :string
  end
end
