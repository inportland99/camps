class AddCampIdToCampSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_surveys, :camp_id, :integer
  end
end
