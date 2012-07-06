class User < ActiveRecord::Base
	authenticates_with_sorcery!
  
	attr_accessible :username, :email, :password, :password_confirmation

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_presence_of :username
	validates_uniqueness_of :email
	validates_uniqueness_of :username
   has_one :player
  # attr_accessible :title, :body
end
