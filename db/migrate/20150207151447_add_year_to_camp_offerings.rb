class AddYearToCampOfferings < ActiveRecord::Migration
  def change
    add_column :camp_offerings, :year, :integer
  end
end
