class AddVideoUrlToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :video_url, :text
  end
end
