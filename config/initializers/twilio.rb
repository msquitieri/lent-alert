require Rails.root.join('config/twilio.rb')

Twilio.configure do |config|
  config.account_sid = TWILIO_CONFIG['account_sid']
  config.auth_token = TWILIO_CONFIG['auth_token']
end