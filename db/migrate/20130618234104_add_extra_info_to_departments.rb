class AddExtraInfoToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :active, :boolean, null: false, default: true
    add_column :departments, :large, :boolean, null: false, default: false

    add_index :departments, :active

  end
end
