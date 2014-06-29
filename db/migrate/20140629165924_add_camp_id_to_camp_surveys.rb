class AddCampIdToCampSurveys < ActiveRecord::Migration
  def change
    add_column :camp_surveys, :camp_id, :integer
  end
end
