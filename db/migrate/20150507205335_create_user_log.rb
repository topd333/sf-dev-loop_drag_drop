class CreateUserLog < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :user, index: true
      t.references :loggable, polymorphic: true, index: true
      t.text :action

      t.timestamps
    end
  end
end
