class Signup < ActiveRecord::Base
  attr_accessible :game_id, :nation_id, :password, :status, :player_id
  validates_presence_of :game_id
  validates_presence_of :nation_id
  validates_presence_of :player_id
  belongs_to :game
  belongs_to :player
end
