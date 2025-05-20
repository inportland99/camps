class PonyExpress < ActionMailer::Base
  default from: "Math Plus Academy <#{ENV['GMAIL_ADDRESS']}>" 

  before_action :refresh_gmail_token

  def registration_confirmation(registration)
    @registration = registration

    mail(
      to: "#{registration.parent_email}"
      )
  end

  def camp_reminder(registration)
    @registration = registration

    mail(
      to: @registration.parent_email
      )
  end

  def year_round_enrichment(registration)
    @registration = registration

    mail(
      to: @registration.parent_email,
      subject: '[MPA Camp] Did You Know We Offer Year-Round Enrichment?'
      )
  end

  def like_us_on_facebook(registration)
    @registration = registration

    mail(
      to: @registration.parent_email,
      subject: '[MPA Camp] Earn $25 for Connecting with us on Facebook'
      )
  end

  def excel_at_math(registration)
    @registration = registration

    mail(
      to: @registration.parent_email,
      subject: '[MPA Camp] Do You Know Someone Who Wants Their Child to Excel Academically?'
      )
  end

  def camp_follow_up(registration)
    @registration = registration

    mail(
      to: @registration.parent_email,
      subject: '[MPA Camp] Hope You Enjoyed Camp, Please Leave a Review Online'
      )
  end

  def weekly_report
    @registrations = Registration.where('created_at > ? AND year = ?', Time.now.beginning_of_week, 1)
    @powell_camp_offering_registrations = []
    @new_albany_camp_offering_registrations = []
    @locations = Location.order(:id)
    @admins = User.joins(:roles).where(:roles_users => {:role_id => 1})
    @admins_emails = []

    @admins.each do |a|
      @admins_emails << a.email
    end

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
      to: @admins_emails
      )
  end

  def refresh_gmail_token
    Rails.logger.info "[ApplicationMailer] Refreshing Gmail token..."
    ActionMailer::Base.smtp_settings[:password] = GmailOauth2.access_token
  end

end
