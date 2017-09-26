class RenameSlideAddonsToTemplateAddons < ActiveRecord::Migration
  def self.up
  	rename_table :slide_addons, :template_addons
  end

  def self.down
  	rename_table :template_addons, :slide_addons
  end
end
