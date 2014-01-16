class AddTimeToCampOfferings < ActiveRecord::Migration
  def change
    add_column :camp_offerings, :time, :string
  end
end
