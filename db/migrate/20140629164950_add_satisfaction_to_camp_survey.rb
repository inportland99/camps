class AddSatisfactionToCampSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_surveys, :satisfaction, :integer
  end
end
