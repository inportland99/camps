class AddZoomLinkToCampOfferings < ActiveRecord::Migration
  def change
    add_column :camp_offerings, :zoom_link, :string
  end
end
