class AddOfferingTimeToCampOfferings < ActiveRecord::Migration
  def change
    add_column :camp_offerings, :offering_time, :string
  end
end
