class AddHookListToSlideTemplates < ActiveRecord::Migration
  def change
    add_column :slide_templates, :hook_list, :text
  end
end
