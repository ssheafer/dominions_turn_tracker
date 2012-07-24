class AddStatusCdToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :status_cd, :int
    add_column :signups, :turn, :string
    add_column :signups, :turn_cd, :int
  end
end
