class RemoveStaisfactionFromCampSurvey < ActiveRecord::Migration
  def change
    remove_column :camp_surveys, :staisfaction, :integer
  end
end
