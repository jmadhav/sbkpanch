class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.datetime :date_time
      t.string :notification_type
      t.string :death_of
      t.text :address
      t.boolean :disabled, :default => false
      t.boolean :hide, :default => false
      t.integer :sad_demise_id
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
