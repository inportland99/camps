class PagesController < ApplicationController

  def home
    @months_registrations = Registration.where("created_at >= ?", Time.zone.now.beginning_of_month)
    @todays_registrations = Registration.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end
end
