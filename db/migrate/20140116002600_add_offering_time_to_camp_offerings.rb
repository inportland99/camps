class AddOfferingTimeToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :offering_time, :string
  end
end
