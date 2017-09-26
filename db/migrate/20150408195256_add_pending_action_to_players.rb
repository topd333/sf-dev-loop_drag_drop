class AddPendingActionToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :pending_action, :string
  end
end
