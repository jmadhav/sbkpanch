class Uom < ActiveRecord::Base
  attr_accessible :name, :created_by, :updated_by
  
  # Associations
  has_many :items

  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :name, :created_by, :updated_by
  validates_uniqueness_of :name
  validates_inclusion_of :disabled, in: [true, false]

end
