class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :abbr,     null: false
      t.string :name,     null: false

      t.timestamps
    end

    add_index :buildings, :abbr, unique: true

  end
end
