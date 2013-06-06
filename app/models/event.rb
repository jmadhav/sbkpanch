class Event < ActiveRecord::Base
  attr_accessible :booked_by, :created_by, :description, :disabled, :event_type_id, :from_date_time, :to_date_time, :updated_by

  # Associations
  belongs_to :event_type

  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of  :from_date_time, :to_date_time, :event_type_id, :booked_by, :description,:created_by, :updated_by
  validates_inclusion_of :disabled, in: [true, false]
  validates_uniqueness_of :from_date_time, :to_date_time
  validate :validate_from_date_time_and_to_date_time

  def validate_from_date_time_and_to_date_time
    return self.errors.add(:base, "From date time should be today or after todays date.") unless self.from_date_time >= Date.today.to_time
    return self.errors.add(:base, "To date time should be today or after todays date.") unless self.to_date_time >= Date.today.to_time
  
    return self.errors.add(:base, "From date time should be before To date time.") if self.from_date_time >= self.to_date_time

    unless Event.where("from_date_time < ? AND to_date_time > ? AND id != ?", self.from_date_time, self.from_date_time, self.id).blank?
      return self.errors.add(:base, "From date time clashes with other Event.")
    end

    unless Event.where("from_date_time < ? AND to_date_time > ? AND id != ?", self.to_date_time, self.to_date_time, self.id).blank?
      return self.errors.add(:base, "To date time clashes with other Event.")
    end
    
    unless Event.where(:from_date_time => self.from_date_time..self.to_date_time).where("id != ?", self.id).blank?
     return self.errors.add(:base, "From date time and To datetime clashes with other Event.")
    end

    unless Event.where(:to_date_time =>  self.from_date_time..self.to_date_time).where("id != ?", self.id).blank?
      return self.errors.add(:base, "From date Time and To date time clashes with other Event.")
    end
  end

  # TODO => Validate From Date Time & To Date Time For Specific Item Level

end
