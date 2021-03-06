namespace :mail do
  desc "Send Summer Camps Follow Up Campaign."
  task camp_tuesday_email: :environment do
    if Time.now.tuesday?
      send_tuesday_email
    end
  end
  task camp_wednesday_email: :environment do
    if Time.now.wednesday?
      send_wenesday_email
    end
  end
  task camp_thursday_email: :environment do
    if Time.now.thursday?
      send_thursday_email
    end
  end
  task camp_friday_email: :environment do
    if Time.now.friday?
      send_friday_email
    end
  end
end

def send_tuesday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date <= ? AND start_date > ?", Date.today - 7.days, Date.today)

  @registrations.each do |r|
    if r.parent_email
      PonyExpress.year_round_enrichment(r).deliver
    end
  end
end

def send_wednesday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date <= ? AND start_date > ?", Date.today - 7.days, Date.today)

  @registrations.each do |r|
    if r.parent_email
      PonyExpress.like_us_on_facebook(r).deliver
    end
  end
end

def send_thursday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date <= ? AND start_date > ?", Date.today - 7.days, Date.today)

  @registrations.each do |r|
    if r.parent_email
      PonyExpress.excel_at_math(r).deliver
    end
  end
end

def send_friday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date <= ? AND start_date > ?", Date.today - 7.days, Date.today)

  @registrations.each do |r|
    if r.parent_email
      PonyExpress.camp_follow_up(r).deliver
    end
  end
end
