class AddLastUpdateStampToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :last_update_stamp, :DateTime
  end
end
