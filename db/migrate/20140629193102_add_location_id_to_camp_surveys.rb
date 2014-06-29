class AddLocationIdToCampSurveys < ActiveRecord::Migration
  def change
    add_column :camp_surveys, :location_id, :integer
  end
end
