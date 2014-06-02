namespace :mail do
  desc "Send Confirmation for Summer Camps."
  task camp_reminder_email: :environment do
    if Time.now.thursday?
      send_camp_reminder
    end
  end
end

def send_camp_reminder
  @registrations = Registration.joins(:camp_offerings).where("start_date <= ? AND start_date > ?", Date.today + 7.days, Date.today)

  @registrations.each do |r|
    if r.parent_email
      PonyExpress.camp_reminder(@registration).deliver
    end
  end
end
