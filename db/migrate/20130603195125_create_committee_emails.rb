class CreateCommitteeEmails < ActiveRecord::Migration
  def change
    create_table :committee_emails do |t|
      t.string :email
      t.string :person
      t.string :mobile
      t.boolean :disabled
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
