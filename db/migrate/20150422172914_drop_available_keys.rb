class DropAvailableKeys < ActiveRecord::Migration
  def change
  	drop_table :available_keys do |t|
      t.string :player_key
      t.index :player_key

      t.timestamps
    end
  end
end
