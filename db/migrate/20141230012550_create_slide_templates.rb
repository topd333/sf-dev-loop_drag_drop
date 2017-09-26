class CreateSlideTemplates < ActiveRecord::Migration
  def change
    create_table :slide_templates do |t|
      t.string :name
      t.string :description
      t.boolean :listed
      t.text :markup
      t.belongs_to :organization, index: true
      t.timestamps
    end
  end
end
