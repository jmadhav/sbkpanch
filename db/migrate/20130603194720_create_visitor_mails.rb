class CreateVisitorMails < ActiveRecord::Migration
  def change
    create_table :visitor_mails do |t|
      t.string :from_name
      t.string :from_email
      t.string :from_mobile
      t.integer :visitor_mail_subject_id
      t.text :message
      t.text :to_emails
      t.boolean :disabled
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
