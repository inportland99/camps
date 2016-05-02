require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  protect_from_forgery
  force_ssl if: :ssl_configured?

  def ssl_configured?
    !Rails.env.development?
  end
end
