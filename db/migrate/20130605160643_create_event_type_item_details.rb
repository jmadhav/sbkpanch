class CreateEventTypeItemDetails < ActiveRecord::Migration
  def change
    create_table :event_type_item_details do |t|
      t.integer :item_id
      t.integer :event_type_id

      t.timestamps
    end
  end
end
