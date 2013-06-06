class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.datetime :date_time
      t.string :notification_type
      t.string :death_of
      t.string :place
      t.text :address
      t.boolean :disabled, :default => false
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
