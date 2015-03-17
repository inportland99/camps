class PagesController < ApplicationController

  def home
    if current_user
      @registrations = Registration.where(year: 1)
      @months_registrations = Registration.where("created_at >= ? AND year=?", Time.now.beginning_of_month, 1)
      @months_registrations_last_year = Registration.where("created_at >= ? AND created_at <= ?", (Time.now - 1.year).beginning_of_month, (Time.now - 1.year).end_of_month)
      @percent_different = ((@months_registrations.to_a.sum{ |reg| reg.total } - @months_registrations_last_year.to_a.sum{ |reg| reg.total }).to_f/(@months_registrations_last_year.to_a.sum{ |reg| reg.total }).to_f).round(2) * 100
      @todays_registrations = Registration.where("created_at > ? AND year =?", Time.now.beginning_of_day, 1)
      @camp_interest = CampInterest.new
      @camp_off_reg_count = 0
      @camp_revenue = @registrations.sum(:total)

      @registrations.each do |reg|
        @camp_off_reg_count += reg.camp_offerings.count
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
      redirect_to { redirect_to root_url, notice: 'Invalid id or token.' }
    end
  end
end
