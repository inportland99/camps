class AddSatisfactionToCampSurvey < ActiveRecord::Migration
  def change
    add_column :camp_surveys, :satisfaction, :integer
  end
end
