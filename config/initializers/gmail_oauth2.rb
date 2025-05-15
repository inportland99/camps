# config/initializers/gmail_oauth2.rb
require 'googleauth'

module GmailOauth2
  def self.access_token
    Rails.logger.info "[GmailOauth2] Fetching new access token..."
    creds = Google::Auth::UserRefreshCredentials.new(
      client_id:     ENV['GMAIL_CLIENT_ID'],
      client_secret: ENV['GMAIL_CLIENT_SECRET'],
      refresh_token: ENV['GMAIL_REFRESH_TOKEN'],
      scope:         'https://mail.google.com/'
    )
    creds.fetch_access_token!
    creds.access_token
  end
end