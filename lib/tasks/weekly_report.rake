namespace :mail do
  desc "Send weekly registration report."
  task weekly_report: :environment do
    send_weekly_report
  end
end

def send_weekly_report
  PonyExpress.weekly_report.deliver
end