class Game < ActiveRecord::Base
  attr_accessible :status, :era, :host_id, :era_cd, :host_time, :last_poll, :map_download, :map_preview, :max_players, :message, :name, :players_remaining, :port, :provinces, :requires_passwords, :server, :status_cd, :timer, :turn_number
  as_enum :era, :EA => 0, :MA => 1, :LA => 3, :Other => 4
  as_enum :status, :Pending => 0, :Active => 1, :Complete => 2
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :status_cd
  validates_presence_of :message
  validates :max_players, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :provinces, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :port, :numericality => { :only_integer => true, :greater_than => 0 }
  has_many :signups
  belongs_to :player, :foreign_key => "host_id"
  validates_associated :signups

  def allow_signup?
    @game = self
    @signups = Signup.find_all_by_game_id(@game.id)
    @signups.delete_if {|x| x.player_id < 0}
    if @signups.length < @game.max_players && @game.status.to_s == 'Pending' then return true else return false end
  end
  def self.updateRecords
    @games = Game.find :all, :conditions => {:status_cd => Game.Active}
    threads = Array.new
    @games.each {|game| threads.push(Thread.new{ game.updateGame() }) }
    threads.each {|thread| thread.join()}
  end
  def updateGame()
    begin
    s = TCPSocket.open(self.server, self.port)
      s.write("\x66\x48\x01\x00\x00\x00\x03")
      result = nil
      status = Timeout::timeout(5) {
        result = s.readpartial(512)
      }
      if result != nil
        if result.length < 300
          #error! response should be roughly 320 bytes, depending on name length
          puts "Error in response"
        else
          # see http://www.cs.helsinki.fi/u/aitakang/dom3_serverformat_notes
          data = result.unpack('CCVCCCCCCZ*CCVCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCVC')
          #puts data.inspect
          messageData = data[0,9]
          gameName = data[9]
          era = data[10]
          #data[11] is a constant 0x2d
          tth = data[12]
          #data[13] is a constant 0x00
          nationStatus = data[14, 95]
          submitted = data[109, 95]
          connected = data[204 ,95]
          turnNumber = data[299]
          if turnNumber > self.turn_number then self.sendUpdateEmail()
          self.turn_number = turnNumber
          self.host_time = tth
          self.last_poll = Time.now
          signups = Signup.find_all_by_game_id(self.id)
          signupsByNation = Hash[signups.map {|x| [x.nation_id, x]}]
          signupsByNation.each do |id, value| 
          
            status = nationStatus[id] 
            turn = submitted[id]
            if status == 1 then signupsByNation[id].status = "Alive" end
            if status == 2 then signupsByNation[id].status = "AI" end
            if status == 0xfe then signupsByNation[id].status = "Defeated" end
            if status == 0xff then signupsByNation[id].status = "Defeated_This_Turn" end
            signupsByNation[id].turn_cd = turn
            signupsByNation[id].save
          end

          self.save

        end
      end
      s.close # Close the socket when done 
    rescue
      return false
    ensure
      
    end
    return true

  end
  def sendUpdateEmail()

  end
end
