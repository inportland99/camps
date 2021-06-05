namespace :mail do
  desc "Send Confirmation for Summer Camps."
  task camp_reminder_email: :environment do
    if Time.now.saturday?
      send_camp_reminder
    end
  end
end

def send_camp_reminder
  # @registrations = Registration.joins(:camp_offerings).where("start_date <= ? AND start_date > ?", Date.today + 7.days, Date.today)

  # does the any camp week start within 7 days?
  week = 0
  1.upto(9) do |w|
    if CampOffering::OFFERING_WEEKS[w][:start].between?(Date.today, Date.today + 7)
      week = w
    end
  end

  # retrieve all registrations which include camps from upcoming week
  @registrations = Registration.joins(:camp_offerings).where("week = ?", week)

  @registrations.each do |r|
    # filter out camps canceled for Covid19 - by only sending reminders for online camps
    if r.parent_email && r.location_id == 7 && r.year == 7
      PonyExpress.camp_reminder(r).deliver
    end
  end
end
