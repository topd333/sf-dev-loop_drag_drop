class CreateSlideStringHooks < ActiveRecord::Migration
  def change
    create_table :slide_string_hooks do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :slide_asset, index: true
      t.text :data
      t.string :hook

      t.timestamps
    end
  end
end
