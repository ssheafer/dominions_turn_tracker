class CreateSignups < ActiveRecord::Migration
  def change
    drop_table :signups
    create_table :signups do |t|
      t.integer :game_id
      t.integer :nation_id
      t.integer :user_id
      t.boolean :password
      t.string :status
      t.boolean :turn

      t.timestamps
    end
  end
end
