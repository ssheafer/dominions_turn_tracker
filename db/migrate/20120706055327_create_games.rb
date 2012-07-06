class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :server
      t.integer :port
      t.integer :status_cd
      t.integer :era_cd
      t.integer :provinces
      t.integer :max_players
      t.boolean :requires_passwords
      t.string :timer
      t.integer :turn_number
      t.integer :players_remaining
      t.datetime :host_time
      t.datetime :last_poll
      t.text :message
      t.string :map_preview
      t.string :map_download

      t.timestamps
    end
  end
end
