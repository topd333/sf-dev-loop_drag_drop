class AddUuidToLoopAssets < ActiveRecord::Migration
  def change
    add_column :loop_assets, :uuid, :string
  end
end
