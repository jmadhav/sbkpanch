class EventTypeItemDetail < ActiveRecord::Base
  attr_accessible :event_type_id, :item_id
  
  # Associations
  belongs_to :event_types
  
  # Validations
  validates_presence_of :item_id
  validates_uniqueness_of :item_id, :scope => :event_type_id, :message => "Duplicate Item is not allowed."
  
end
