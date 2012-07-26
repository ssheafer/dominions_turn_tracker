class AddGameKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :game_key, :string
    add_column :users, :matryx_link, :string
  end
end
