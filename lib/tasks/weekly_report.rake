namespace :mail do
  desc "Send weekly registration report."
  task weekly_report: :environment do
    if Time.now.sunday?
      send_weekly_report
    end
  end
end

def send_weekly_report
  PonyExpress.weekly_report.deliver
end