class SubjectEmailDetail < ActiveRecord::Base
  attr_accessible :committee_email_id, :receiver_type, :visitor_mail_subject_id

  # Associations
  belongs_to :visitor_mail_subject
  belongs_to :committee_email

  # Validations
  validates_presence_of  :committee_email_id, :receiver_type
  validates_uniqueness_of :committee_email_id, :scope => :visitor_mail_subject_id, :message => "Duplicate Email is not allowed."

end
