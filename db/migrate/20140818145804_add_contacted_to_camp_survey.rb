class AddContactedToCampSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :camp_surveys, :contacted, :boolean, default: false
  end
end
