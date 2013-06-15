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
    row_count = 0
    self.subject_email_details.each{ |d| if (d._destroy == false); row_count +=1; end }
    self.errors.add(:base, "Please enter Emails for #{self.class.to_s} ")  if row_count == 0
  end
end
