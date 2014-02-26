dom3-goons
==========

A website to manage Dominions 3 game signup and track the status of each game.  Made for the SomethingAwful goons

Install:
Install Ruby 1.9.3 (I used rbenv)

check out project into directory
sudo su
source /etc/profile.d/rbenv.sh
gem install bundler
bundle install

Configure:
create database.yml in config/
rake db:migrate RAILS_ENV="production"
set token for cookies in config/initializers/secret_token.rb (Dom3::Application.config.secret_token = ...)
rake assets:precompile
config/initializers/sorcery.rb disable user authentication
Get Recaptcha key (https://www.google.com/recaptcha/admin/create) - config/initializers/recaptcha.rb


Deploy:
Install Phusion Passenger
Create website configuration file in apache config dir/sites-available
sudo a2ensite
http://www.modrails.com/documentation/Users%20guide%20Apache.html