class AddMetaColumnsToPlayers < ActiveRecord::Migration
  def change
    add_reference :players, :admin_hardware_type, index: true
    add_column :players, :serial_number, :string
    add_reference :players, :admin_pay_program, index: true
  end
end
