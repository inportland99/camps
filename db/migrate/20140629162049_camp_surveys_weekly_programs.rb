class CampSurveysWeeklyPrograms < ActiveRecord::Migration
  def change
    create_table :camp_surveys_weekly_programs, :id => false do |t|
       t.references :camp_survey, :null => false
       t.references :weekly_program, :null => false
    end
    add_index :camp_surveys_weekly_programs,
              [:camp_survey_id, :weekly_program_id],
              :name => 'samp_survery_prog'
  end
end
