class AddContactedToCampSurvey < ActiveRecord::Migration
  def change
    add_column :camp_surveys, :contacted, :boolean, default: false
  end
end
