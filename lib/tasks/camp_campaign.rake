namespace :mail do
  desc "Send Summer Camps Follow Up Campaign."
  task camp_campaign: :environment do
    if Time.now.monday?
      add_to_infusionsoft_campaign
    end
  end
end

def add_to_infusionsoft_campaign
  # Pull registration that have camps starting today.
  registrations = Registration.joins(:camp_offerings).where("start_date = ?", Date.today)

  registrations.each do |registration|
    if registration.infusionsoft_id
      Infusionsoft.contact_add_to_group(registration.infusionsoft_id, 2304) # start summer camp campaign
    else
      puts "No infusionsoft_id for registration #{registration.id}!"
    end
  end
end
