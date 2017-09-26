class AddUniqkeyToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :uniqkey, :string
  end
end
