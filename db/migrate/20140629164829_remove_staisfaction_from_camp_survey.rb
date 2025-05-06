class RemoveStaisfactionFromCampSurvey < ActiveRecord::Migration[6.0]
  def change
    remove_column :camp_surveys, :staisfaction, :integer
  end
end
