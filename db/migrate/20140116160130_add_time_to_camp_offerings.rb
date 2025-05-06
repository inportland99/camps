class AddTimeToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :time, :string
  end
end
