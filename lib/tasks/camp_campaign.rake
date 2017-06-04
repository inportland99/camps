namespace :mail do
  desc "Send Summer Camps Follow Up Campaign."
  task camp_campaign: :environment do
    if Time.now.monday?
      add_to_infusionsoft_campaign
    end
  end
end

def send_tuesday_email
  # Pull registration that have camps starting today.
  @registrations = Registration.joins(:camp_offerings).where("start_date = ?", Date.today)

  @registrations.each do |registration|
    Infusionsoft.contact_add_to_group(registration.infusionsoft_id, 2304) # start summer camp campaign
  end
end
