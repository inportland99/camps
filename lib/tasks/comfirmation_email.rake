namespace :mail do
  desc "Send Confirmation for Summer Camps."
  task camp_reminder_email: :environment do
    if Time.now.sunday? || Time.now.sunday?
      send_camp_reminder
    end
  end
end

def send_camp_reminder
  # @registrations = Registration.joins(:camp_offerings).where("start_date <= ? AND start_date > ?", Date.today + 7.days, Date.today)

  # is next friday within a camp week?
  week = 0
  1.upto(9) do |w|
    if CampOffering::OFFERING_WEEKS[w][:start] < Date.today + 4 && CampOffering::OFFERING_WEEKS[w][:end] > Date.today + 4
      week = w
    end
  end

  # retrieve all registrations which include camps from upcoming week
  @registrations = Registration.joins(:camp_offerings).where("week = ?", week)

  @registrations.each do |r|
    # filter out camps canceled for Covid19 - by only sending reminders for online camps
    if r.parent_email && r.location_id == 7 && r.year == 6
      PonyExpress.camp_reminder(r).deliver
    end
  end
end
