class ChangeUserDataTypes < ActiveRecord::Migration
  def up
  	change_column :players, :forum_id, :string
  	change_column :players, :timezone, :string
  end

  def down
  end
end
