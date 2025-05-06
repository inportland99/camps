class AddYearToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :year, :integer
  end
end
