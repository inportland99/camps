class AddExtendedCareToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :extended_care, :boolean, default: false
  end
end
