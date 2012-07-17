class Game < ActiveRecord::Base
  attr_accessible :status, :era, :host_id, :era_cd, :host_time, :last_poll, :map_download, :map_preview, :max_players, :message, :name, :players_remaining, :port, :provinces, :requires_passwords, :server, :status_cd, :timer, :turn_number
  as_enum :era, :EA => 0, :MA => 1, :LA => 3, :Other => 4
  as_enum :status, :Pending => 0, :Active => 1, :Complete => 2
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :status_cd
  validates_presence_of :message
  validates :max_players, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :provinces, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :port, :numericality => { :only_integer => true, :greater_than => 0 }
  has_many :signups
  belongs_to :player, :foreign_key => "host_id"
  validates_associated :signups
end
