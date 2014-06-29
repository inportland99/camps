class CampSurvey < ActiveRecord::Base
  has_and_belongs_to_many :weekly_programs,  :join_table => :camp_surveys_weekly_programs
  belongs_to :camp
  belongs_to :location

  SATISFACTION_LEVELS = ["Very Satisfied", "Satisfied", "Somewhat Satisfied", "Not Sure"]
  CONTACT_METHOD = ["PHONE", "EMAIL"]
end
