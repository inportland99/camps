class AddWeekToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :week, :integer
  end
end
