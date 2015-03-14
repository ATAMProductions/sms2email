class UserMailer < ApplicationMailer
  default from: "mailer@zzv.ca"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup.subject
  #
  def signup(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, subject: "Welcome to sms2email!"
  end
  
  def msg(em, msg, subject)
    @email = em
    @msg = msg 
    
    mail to: em, subject: subject
  end
end
