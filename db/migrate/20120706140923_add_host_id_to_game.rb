class AddHostIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :host_id, :integer
  end
end
