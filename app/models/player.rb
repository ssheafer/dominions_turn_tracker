class Player < ActiveRecord::Base
  attr_accessible :aim, :avatar, :email_pref, :forum_id, :googletalk, :icq, :msn_messenger, :other, :steam, :timezone, :user_id, :xfire, :yahoo_messenger
  belongs_to :user
  after_create :init

  def init
  	self.email_pref = true
  end
end
