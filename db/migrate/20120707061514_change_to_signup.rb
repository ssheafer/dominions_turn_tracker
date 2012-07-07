class ChangeToSignup < ActiveRecord::Migration
  def change
  	remove_column :signups, :turn
  	change_column :signups, :password, :string
  end
end
