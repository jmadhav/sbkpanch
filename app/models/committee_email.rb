class CommitteeEmail < ActiveRecord::Base
  attr_accessible :created_by, :disabled, :email, :mobile, :person, :updated_by
  
  # TODO => Associations
  
  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :email, :mobile, :person, :created_by, :updated_by
  validates_uniqueness_of :email, :mobile, :person
  validates_inclusion_of :disabled, in: [true, false]

  # TODO => Validate Email Domain Name

end
