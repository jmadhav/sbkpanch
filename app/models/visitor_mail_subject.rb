class VisitorMailSubject < ActiveRecord::Base
  attr_accessible :created_by, :disabled, :subject, :updated_by

  # Associations
  has_many :visitor_mails

  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :subject, :created_by, :updated_by
  validates_uniqueness_of :subject
  validates_inclusion_of :disabled, in: [true, false]

end
