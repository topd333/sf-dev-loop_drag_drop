class AddDiagnosticsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :diagnostics, :text
  end
end
