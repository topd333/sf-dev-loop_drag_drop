class AddAccessCodeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :access_code, :string
  end
end
