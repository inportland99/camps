class PagesController < ApplicationController

  def home
    if current_user
      @registrations = Registration.where(year: CampOffering::CURRENT_YEAR)
      @locations = Location.all
      @months_registrations = Registration.where("created_at >= ? AND year=?", Time.now.beginning_of_month, CampOffering::CURRENT_YEAR)
      @this_years_registrations_to_date = Registration.where("created_at >= ?", Date.today.beginning_of_year)
      @last_years_registrations_to_date = Registration.where("created_at <= ? AND created_at >= ?", Date.today - 1.year, (Date.today - 1.year).beginning_of_year)

      @last_years_revenue_to_date = @last_years_registrations_to_date.sum(:total)

      @this_years_revenue_to_date = @this_years_registrations_to_date.sum(:total)

      @percent_difference = ((@this_years_revenue_to_date - @last_years_revenue_to_date).to_f / @last_years_revenue_to_date.to_f * 100).round(2)

      # ((@months_registrations.to_a.sum{ |reg| reg.total } - @months_registrations_last_year.to_a.sum{ |reg| reg.total }).to_f/(@months_registrations_last_year.to_a.sum{ |reg| reg.total }).to_f).round(2) * 100
      @todays_registrations = Registration.where("created_at > ? AND year =?", Time.now.beginning_of_day, CampOffering::CURRENT_YEAR)
      @camp_interest = CampInterest.new
      @camp_revenue = @registrations.sum(:total)

      @camp_off_reg_count = 0
      @registrations.each do |reg|
        @camp_off_reg_count += reg.camp_offerings.reject{ |co| co.extended_care? }.count
      end

      # Data for solon camp overview page
      @solon_registrations = @registrations.where("location_id = 6")
      @solon_camp_count = 0
      @solon_registrations.each do |reg|
        @solon_camp_count += reg.camp_offerings.reject{ |co| co.extended_care? }.count
      end
      @solon_revenue = @solon_registrations.sum(:total)

      @coupon_codes_by_count = Array.new
      CouponCode.all.each do |coupon|
        name = coupon.name
        count = 0
        @registrations.each do |reg|
          if reg.coupon_code && reg.coupon_code.upcase == name
            count += reg.camp_offerings.count
          end
        end
        @coupon_codes_by_count.push({name: name, count: count})
      end
    else
      # bypass the home page and go straight to online reg page
      redirect_to new_registration_path(location: 7)
    end
  end

  def faq
  end

  def comparison
  end

  def testimonials
  end

  def terms
  end

  def privacy
  end

  def thank_you
    if params[:id]
      @registration = Registration.find(params[:id])
    end
  end

  def reminder_thank_you
    #code
  end

  def googlea898a912abc4e23c
    render :layout => false
  end
end
