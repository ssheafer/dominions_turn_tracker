class UserMailer < ActionMailer::Base
  default from: "GGS@scamp.me"

  def activation_needed_email(user)
    @user = user
    @url  = "http://scamp.me:3000/users/#{user.activation_token}/activate"
    mail(:bcc => Dom3::ConstData::ADMINS, :subject => "User Signup")
  end

  def activation_success_email(user)
    @user = user
    @url  = "http://scamp.me:3000/login"
    mail(:to => user.email,
       :subject => "Your account is now activated")
  end
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
