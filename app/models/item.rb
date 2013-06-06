class Item < ActiveRecord::Base
  attr_accessible :created_by, :description, :disabled, :item_type_id, :name, :uom_id, :updated_by

  # Associations
  belongs_to :uom
  belongs_to :item_type

  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :name, :description, :item_type_id, :uom_id, :created_by, :updated_by
  validates_uniqueness_of :name
  validates_inclusion_of :disabled, in: [true, false]
  
end
