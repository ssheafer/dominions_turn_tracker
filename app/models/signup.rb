class Signup < ActiveRecord::Base
  attr_accessible :game_id, :nation_id, :password, :status, :turn, :user_id
  validates_presence_of :game_id
  validates_presence_of :nation_id
  validates_presence_of :user_id
  belongs_to :game
end
