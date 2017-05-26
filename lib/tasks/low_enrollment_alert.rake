namespace :camp_offerings do
  desc "Collect emails from parents who have students in camps with low enrollment."
  task low_enrollment: :environment do
    low_enrollment_emails
  end
end

def low_enrollment_emails
  camp_offerings = CampOffering.where(year: CampOffering::CURRENT_YEAR)
  low_enrollment_camp_ids = []
  camp_offerings.each do |camp_offering|
    if camp_offering.open_spots >= camp_offering.camp.capacity - 3
      low_enrollment_camp_ids << camp_offering.id
    end
  end
  puts low_enrollment_camp_ids

  low_enrollment_registrations = []
  low_enrollment_camp_ids.each do |camp_id|
    camp_offering = CampOffering.find(camp_id)
    camp_registrations = camp_offering.registrations
    camp_registrations.each{|registration| low_enrollment_registrations << registration}
  end

  low_enrollment_registrations

  file = CSV.generate do |csv|
      csv << Registration.column_names
      low_enrollment_registrations.each do |registration|
        csv << registration.attributes.values_at(*Registration.column_names)
      end
    end
  puts file
end
