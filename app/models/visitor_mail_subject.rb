class VisitorMailSubject < ActiveRecord::Base
  attr_accessible :created_by, :disabled, :subject, :updated_by, :subject_email_details_attributes

  # Associations
  has_many :visitor_mails
  has_many :subject_email_details
  accepts_nested_attributes_for :subject_email_details, :reject_if => lambda { |i| i[:committee_email_id].blank? }, :allow_destroy => true

  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :subject, :created_by, :updated_by
  validates_uniqueness_of :subject
  validates_inclusion_of :disabled, in: [true, false]
  validate :validate_subject_email_details
  
  def validate_subject_email_details
    row_count, cc_count, bcc_count = 0, 0, 0
    self.subject_email_details.each do |d|
      row_count += 1  if (d._destroy == false)
      cc_count += 1 if d.receiver_type == "Cc:"
      bcc_count += 1 if d.receiver_type == "Bcc:"
    end
    self.errors.add(:base, "Only single Cc: receiver type is allowed") if cc_count > 1
    self.errors.add(:base, "Only single Bcc: receiver type is allowed") if bcc_count > 1
    self.errors.add(:base, "Please enter Emails for #{self.class.to_s} ")  if row_count == 0
  end
end
