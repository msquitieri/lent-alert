class LentenMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.lenten.lent_alert.subject
  #
  def lent_alert(user)
    @user = user

    mail to: user.email, subject: 'LENT ALERT'
  end
end
