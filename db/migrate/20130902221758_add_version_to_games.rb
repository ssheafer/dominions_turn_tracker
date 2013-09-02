class AddVersionToGames < ActiveRecord::Migration
  def change
    add_column :games, :version, :int, :null => false, :default => 3
    add_index :games, :version
  end
end
