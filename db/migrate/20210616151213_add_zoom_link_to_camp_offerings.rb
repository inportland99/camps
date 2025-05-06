class AddZoomLinkToCampOfferings < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_offerings, :zoom_link, :string
  end
end
