class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name
      t.string :display_name
      t.string :booked
      t.text :description
      t.boolean :disabled
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
