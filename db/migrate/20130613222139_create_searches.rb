class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer   :term_id,       null: false

      t.time      :start_time
      t.time      :end_time

      t.boolean   :monday,            null: false, default: true
      t.boolean   :tuesday,           null: false, default: true
      t.boolean   :wednesday,         null: false, default: true
      t.boolean   :thursday,          null: false, default: true
      t.boolean   :friday,            null: false, default: true
      t.boolean   :saturday,          null: false, default: false
      t.boolean   :sunday,            null: false, default: false

      t.string    :statuses

      t.text      :courses_list

      t.string    :required_ccodes

      t.string    :save_code

      t.timestamps
    end

    add_index :searches, :save_code

  end
end
