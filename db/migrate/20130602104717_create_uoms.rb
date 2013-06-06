class CreateUoms < ActiveRecord::Migration
  def change
    create_table :uoms do |t|
      t.string :name
      t.boolean :disabled, :default=> false
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
