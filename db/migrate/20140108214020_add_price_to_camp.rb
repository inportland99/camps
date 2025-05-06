class AddPriceToCamp < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :price, :integer
  end
end
