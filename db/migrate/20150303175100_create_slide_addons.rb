class CreateSlideAddons < ActiveRecord::Migration
  def change
    create_table :slide_addons do |t|
      t.belongs_to :organization, index: true
      t.string :displayname
      t.string :hook, index: true

      t.timestamps
    end
  end
end
