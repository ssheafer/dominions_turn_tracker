class AddSaIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sa_id, :string
  end
end
