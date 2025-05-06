class AddGirlsOnlyToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :girls_only, :boolean, default: false
  end
end
