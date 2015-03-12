class UserMailer < ApplicationMailer
  default from: "massaad@gmail.com"
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
  
  def msg(user, msg, subject)
    @user = user
    @msg = msg 
    
    mail to: user.email, subject: subject
  end
end
