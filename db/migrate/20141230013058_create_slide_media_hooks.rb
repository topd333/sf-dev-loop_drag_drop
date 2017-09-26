class CreateSlideMediaHooks < ActiveRecord::Migration
  def change
    create_table :slide_media_hooks do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :slide_asset, index: true
      t.belongs_to :media_asset, index: true
      t.string :hook

      t.timestamps
    end
  end
end
