class UserMailer < ActionMailer::Base
  default from: "GGS@brainwrinkle.net"

  def activation_needed_email(user)
    @user = user
    @url  = "http://www.brainwrinkle.net/users/#{user.activation_token}/activate"
    @admins = User.where(:admin => true).map {|x| x.email}
    if @admins.length < 1 then @admins = Dom3::ConstData::ADMINS end
    mail(:bcc => @admins, :subject => "User Signup")
  end

  def activation_success_email(user)
    @user = user
    @url  = "http://www.brainwrinkle.net/login"
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
    @url  = "http://www.brainwrinkle.net/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
         :subject => "Your password reset request")
  end

  def turn_email(game)
    @game = game
    playerIDs = game.signups.map{|s| s.player_id}.uniq
    users = Player.find(playerIDs).reject{|p| !p.email_pref }.map{|p| p.user}
    if users.length > 0
      users.each do |user|
        mail(:to => user.email,
             :subject => "[Dom3 GGS] New Turn Alert : #{game.name} : Turn #{game.turn_number}")
      end
    end
  end
end
