class EventType < ActiveRecord::Base
  attr_accessible :created_by, :description, :disabled, :display_name, :name, :booked, :updated_by, :event_type_item_details_attributes

  # Associations
  has_many :events
  has_many :event_type_item_details, :dependent => :destroy
  accepts_nested_attributes_for :event_type_item_details, :reject_if => lambda { |i| i[:item_id].blank? }, :allow_destroy => true

  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :name, :display_name, :booked, :description, :created_by, :updated_by
  validates_length_of :description, :maximum => 50
  validates_uniqueness_of :name, :scope => :display_name
  validates_inclusion_of :disabled, in: [true, false]
  validate :validate_event_type_item_details
  
  def validate_event_type_item_details
    row_count = 0
    self.event_type_item_details.each{ |d| if (d._destroy == false); row_count +=1; end }
    self.errors.add(:base, "Please enter Items for #{self.class.to_s} ")  if row_count == 0
  end

end
