class CreateAdminPayPrograms < ActiveRecord::Migration
  def change
    create_table :admin_pay_programs do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.boolean :available
      t.string :period

      t.timestamps
    end
  end
end
