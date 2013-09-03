class AddVersionToGames < ActiveRecord::Migration
  def change
    add_column :games, :version_cd, :int, :null => false, :default => 3
  end
end
