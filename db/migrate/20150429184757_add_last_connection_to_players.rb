class AddLastConnectionToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :last_connection, :datetime
  end
end
