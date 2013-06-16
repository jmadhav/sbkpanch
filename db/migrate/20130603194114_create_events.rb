class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :from_date_time
      t.datetime :to_date_time
      t.integer :event_type_id
      t.string :booked_by
      t.string :booked
      t.text :description
      t.boolean :disabled
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
