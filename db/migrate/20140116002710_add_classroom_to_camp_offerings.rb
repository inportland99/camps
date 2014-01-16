class AddClassroomToCampOfferings < ActiveRecord::Migration
  def change
    add_column :camp_offerings, :classroom, :integer
  end
end
