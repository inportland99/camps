class CampSurvey < ActiveRecord::Base
  has_and_belongs_to_many :weekly_programs,  :join_table => :camp_surveys_weekly_programs
  belongs_to :camp
  belongs_to :location

  SATISFACTION_LEVELS = ["Very Satisfied", "Satisfied", "Somewhat Satisfied", "Not Sure"]
  CONTACT_METHOD = ["Phone", "Email"]

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      camp_survey = find_by_id(row["id"]) || new
      camp_survey.attributes = row.to_hash.slice(*accessible_attributes)
      camp_survey.save!
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |camp_survey|
        csv << camp_survey.attributes.values_at(*column_names)
      end
    end
  end
end
