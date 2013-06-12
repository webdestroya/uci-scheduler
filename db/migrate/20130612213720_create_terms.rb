class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string  :code,      null: false
      t.string  :name,      null: false
      t.boolean :current,   null: false, default: false

      t.timestamps
    end

    add_index :terms, :code, unique: true
    add_index :terms, :current

  end
end
