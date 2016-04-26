class AddVideoUrlToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :video_url, :text
  end
end
