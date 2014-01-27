class PagesController < ApplicationController

  def home
    @todays_registrations = Registration.where("created_at >= ?", Time.zone.now.beginning_of_month)
    @todays_sales = 0

      @todays_registrations.each do |r|
        @todays_sales = @todays_sales + r.total
      end

  end
end
