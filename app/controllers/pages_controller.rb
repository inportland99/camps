class PagesController < ApplicationController

  def home
    if current_user
      @registrations = Registration.where(year: 1)
      @months_registrations = Registration.where("created_at >= ? AND year=?", Time.now.beginning_of_month, 1)
      @this_years_registrations_to_date = Registration.where("created_at <= ? AND created_at >= ?", Date.today, Date.today.beginning_of_year)
      @last_years_registrations_to_date = Registration.where("created_at <= ? AND created_at >= ?", Date.today - 1.year, (Date.today - 1.year).beginning_of_year)

      @last_years_revenue_to_date = @last_years_registrations_to_date.sum(:total)

      @this_years_revenue_to_date = @this_years_registrations_to_date.sum(:total)

      @percent_different = ((@this_years_revenue_to_date - @last_years_revenue_to_date).to_f / @last_years_revenue_to_date.to_f * 100).round(2)

      # ((@months_registrations.to_a.sum{ |reg| reg.total } - @months_registrations_last_year.to_a.sum{ |reg| reg.total }).to_f/(@months_registrations_last_year.to_a.sum{ |reg| reg.total }).to_f).round(2) * 100
      @todays_registrations = Registration.where("created_at > ? AND year =?", Time.now.beginning_of_day, 1)
      @camp_interest = CampInterest.new
      @camp_revenue = @registrations.sum(:total)

      @camp_off_reg_count = 0
      @registrations.each do |reg|
        @camp_off_reg_count += reg.camp_offerings.reject{ |co| co.extended_care? }.count
      end

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
    end
  end

  def faq
  end

  def comparison
  end

  def testimonials
  end

  def reg_confirmation
    @registration = Registration.find(params[:id])

    unless params[:token] == @registration.stripe_charge_token
      redirect_to { redirect_to root_url, notice: 'No need to go there :)' }
    end
  end
end
