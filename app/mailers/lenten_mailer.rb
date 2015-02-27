class LentenMailer < ApplicationMailer

  def lent_alert(user, email)
    @user = user
    @email = email

    mail to: user.email, subject: @email.subject
  end
end
