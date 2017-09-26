class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :organization, index: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
