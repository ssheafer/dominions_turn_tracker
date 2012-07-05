class UserMailer < ActionMailer::Base
  default from: "GGS@scamp.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
 def reset_password_email(user)
    @user = user
    @url  = "http://scamp.me:3000/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
         :subject => "Your password reset request")
  end
end
