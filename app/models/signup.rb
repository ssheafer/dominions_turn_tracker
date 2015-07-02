class Signup < ActiveRecord::Base
  attr_accessible :game_id, :nation_id, :password, :status, :player_id, :status_cd, :turn, :turn_cd, :username
  as_enum :status, :Alive => 0, :AI => 1, :Defeated => 3, :Defeated_This_Turn => 4
  as_enum :turn, :Outstanding => 0, :Partial => 1, :Submitted => 2
  validates_presence_of :game_id
  validates_presence_of :nation_id
  validates_presence_of :player_id
  belongs_to :game
  belongs_to :player
  validates :nation_id, :uniqueness => {:scope => :game_id,
                                        :message => "each nation can only have 1 signup per game"}

  validates :game_id, :numericality => { :only_integer => true}
  validates :nation_id, :numericality => { :only_integer => true, :greater_than => -1, :less_than => 201 }
  validates :player_id, :numericality => { :only_integer => true, :greater_than => -1 }
  validates :password, :presence => true, :if => :passwordRequired?
  after_create :init

  def init
    self.status = :Alive
    self.turn = :Outstanding
  end

  def passwordRequired?
    self.game.requires_passwords
  end

  def username
    if self.player.nil?
      return ''
    else
      return self.player.user.username
    end

  end

  def username=(name)
    user = User.find_by_username(name)
    if !user.nil?
      self.player_id = user.player.id
    end
  end
end
