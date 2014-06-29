class WeeklyProgram < ActiveRecord::Base
  has_and_belongs_to_many :camp_surveys,  :join_table => :camp_surveys_weekly_programs
end
