class PonyExpress < ActionMailer::Base
  default from: "info@mathplusacademy.com"

  def registration_confirmation(registration)
    @registration = registration

    mail(
      to: "#{registration.parent_email}"
      )
  end
end