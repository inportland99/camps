class AddHiddenToCampOfferings < ActiveRecord::Migration
  def change
    add_column :camp_offerings, :hidden, :boolean
  end
end
