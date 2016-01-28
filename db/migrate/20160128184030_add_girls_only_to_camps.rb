class AddGirlsOnlyToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :girls_only, :boolean, default: false
  end
end
