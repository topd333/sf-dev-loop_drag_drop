class AddAttachmentFileToSlideAddons < ActiveRecord::Migration
  def self.up
    change_table :slide_addons do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :slide_addons, :file
  end
end
