class AddHiddenToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :hidden, :boolean
  end
end
