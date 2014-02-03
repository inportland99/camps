class PagesController < ApplicationController

  def home
    @registrations = Registration.all
    @months_registrations = Registration.where("created_at >= ?", Time.zone.now.beginning_of_month)
    @todays_registrations = Registration.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @camp_off_reg_count = 0

    @registrations.each do |reg|
      @camp_off_reg_count += reg.camp_offerings.count
    end
  end
end
