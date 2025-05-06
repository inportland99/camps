class AddLocationIdToCampSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_surveys, :location_id, :integer
  end
end
