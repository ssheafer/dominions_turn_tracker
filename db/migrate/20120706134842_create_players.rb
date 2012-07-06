class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id
      t.integer :forum_id
      t.string :avatar
      t.string :aim
      t.string :icq
      t.string :xfire
      t.string :googletalk
      t.string :yahoo_messenger
      t.string :steam
      t.string :msn_messenger
      t.string :other
      t.integer :timezone
      t.boolean :email_pref

      t.timestamps
    end
  end
end
