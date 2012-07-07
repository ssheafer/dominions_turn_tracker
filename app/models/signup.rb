class Signup < ActiveRecord::Base
  attr_accessible :game_id, :nation_id, :password, :status, :turn, :player_id
  validates_presence_of :game_id
  validates_presence_of :nation_id
  validates_presence_of :user_id
  belongs_to :game
  belongs_to :player
end
