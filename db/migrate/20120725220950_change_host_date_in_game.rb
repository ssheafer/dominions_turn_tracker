class ChangeHostDateInGame < ActiveRecord::Migration
  def change
  	change_column :games, :host_time, :int
  end
end
