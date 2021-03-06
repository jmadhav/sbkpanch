class VisitorMail < ActiveRecord::Base
  attr_accessible :created_by, :disabled, :from_name, :from_email, :from_mobile, :message, :visitor_mail_subject_id, :to_emails, :updated_by

  # Associations
  belongs_to :visitor_mail_subject

  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :from_email, :from_mobile, :message, :visitor_mail_subject_id, :to_emails, :created_by, :updated_by
  validates_inclusion_of :disabled, in: [true, false]
  
end
