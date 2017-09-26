class RemoveLengthFromLoopAssets < ActiveRecord::Migration
  def change
    remove_column :loop_assets, :length, :integer
  end
end
