class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.string :name
      t.boolean :disabled
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
