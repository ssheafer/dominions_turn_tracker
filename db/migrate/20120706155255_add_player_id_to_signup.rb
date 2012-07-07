class AddPlayerIdToSignup < ActiveRecord::Migration
  def change
    add_column :signups, :player_id, :integer
    remove_column :signups, :user_id
  end
end
