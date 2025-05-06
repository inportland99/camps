class AddClassroomToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :classroom, :integer
  end
end
