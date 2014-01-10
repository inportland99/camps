class AddPriceToCamp < ActiveRecord::Migration
  def change
    add_column :camps, :price, :integer
  end
end
