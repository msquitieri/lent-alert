class User < ActiveRecord::Base
  TWILIO_NUMBER = '+16785682578'

  validates_uniqueness_of :email, allow_nil: true
  validates_uniqueness_of :phone_number, allow_nil: true
  validates_plausible_phone :phone_number, :country_code => 'US'

  phony_normalize :phone_number, :default_country_code => 'US'
  validate :presence_of_contact_information
  validate :format_of_contact_information

  validates_presence_of :alert_hour, :alert_minute

  def send_alert
    if phone_number.present?
      send_alert_via_text
    else
      send_alert_via_email
    end
  end

  private

  def send_alert_via_text
    Twilio::REST::Client.new.messages.create(
      from: TWILIO_NUMBER,
      to: phone_number,
      message: Message.last.text
    )
  end

  def send_alert_via_email
    LentenMailer.lent_alert(self).deliver_now
  end

  def presence_of_contact_information
    raise 'Either email or phone_number must be set' if email.nil? && phone_number.nil?
  end

  def format_of_contact_information
    raise 'Email is not in the correct format' if email.present? and not EmailValidator.valid?(email)
  end
end
