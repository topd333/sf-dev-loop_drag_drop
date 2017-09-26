class AddActivatedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :activated, :boolean
  end
end
