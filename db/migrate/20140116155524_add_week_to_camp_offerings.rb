class AddWeekToCampOfferings < ActiveRecord::Migration
  def change
    add_column :camp_offerings, :week, :integer
  end
end
