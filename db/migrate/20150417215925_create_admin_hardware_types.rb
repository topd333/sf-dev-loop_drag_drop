class CreateAdminHardwareTypes < ActiveRecord::Migration
  def change
    create_table :admin_hardware_types do |t|
      t.string :model_number
      t.text :description

      t.timestamps
    end
  end
end
