class CreateVisitorMailSubjects < ActiveRecord::Migration
  def change
    create_table :visitor_mail_subjects do |t|
      t.text :subject
      t.boolean :disabled
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
