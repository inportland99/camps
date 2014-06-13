namespace :mail do
  desc "Send Summer Camps Follow Up Campaign."
  task camp_campaign: :environment do
    if Time.now.tuesday?
      send_tuesday_email
    end

    if Time.now.wednesday?
      send_wenesday_email
    end

    if Time.now.thursday?
      send_thursday_email
    end

    if Time.now.friday?
      send_friday_email
    end
  end
end

def send_tuesday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date >= ? AND start_date < ?", Date.today - 7.days, Date.today)
  parent_emails = []

  @registrations.each do |r|
    if r.parent_email && !parent_emails.include?(r.parent_email)
      parent_emails << r.parent_email
      PonyExpress.year_round_enrichment(r).deliver
    end
  end
end

def send_wednesday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date >= ? AND start_date < ?", Date.today - 7.days, Date.today)
  parent_emails = []

  @registrations.each do |r|
    if r.parent_email && !parent_emails.include?(r.parent_email)
      parent_emails << r.parent_email
      PonyExpress.like_us_on_facebook(r).deliver
    end
  end
end

def send_thursday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date >= ? AND start_date < ?", Date.today - 7.days, Date.today)
  parent_emails = []

  @registrations.each do |r|
    if r.parent_email && !parent_emails.include?(r.parent_email)
      parent_emails << r.parent_email
      PonyExpress.excel_at_math(r).deliver
    end
  end
end

def send_friday_email
  @registrations = Registration.joins(:camp_offerings).where("start_date >= ? AND start_date < ?", Date.today - 7.days, Date.today)
  parent_emails = []

  @registrations.each do |r|
    if r.parent_email && !parent_emails.include?(r.parent_email)
      parent_emails << r.parent_email
      PonyExpress.camp_follow_up(r).deliver
    end
  end
end
