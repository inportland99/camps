class PonyExpress < ActionMailer::Base
  default from: "info@mathplusacademy.com"

  def registration_confirmation(registration)
    @registration = registration

    mail(
      to: "#{registration.parent_email}"
      )
  end

  def weekly_report
    @registrations = Registration.where('created_at > ?', Time.now.beginning_of_week)
    @powell_camp_offering_registrations = []
    @new_albany_camp_offering_registrations = []
    @locations = Location.order(:id)

    @registrations.each do |reg|
      if reg.camp_offerings.first.location_id == 1
        reg.camp_offerings.each do |p_co|
          @powell_camp_offering_registrations << p_co
        end
      elsif reg.camp_offerings.first.location_id == 2
        reg.camp_offerings.each do |na_co|
          @new_albany_camp_offering_registrations << na_co
        end
      end
    end

    mail(
      to: "director@mathplusacademy.com, tkendalls1@gmail.com"
      )
  end
end