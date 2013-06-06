class CreateSubjectEmailDetails < ActiveRecord::Migration
  def change
    create_table :subject_email_details do |t|
      t.integer :visitor_mail_subject_id
      t.integer :committee_email_id
      t.string :receiver_type

      t.timestamps
    end
  end
end
