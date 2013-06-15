class Notification < ActiveRecord::Base
  attr_accessible :date_time, :notification_type, :death_of, :address, :created_by, :updated_by
  
  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of :date_time, :notification_type, :death_of, :address, :created_by, :updated_by
  validates_uniqueness_of :death_of, :scope => :notification_type
  validates_inclusion_of :notification_type, in: ["Death", "Condolence"]
  validates_inclusion_of :disabled, in: [true, false]
  
  validate :validate_date_time

  def validate_date_time
    return self.errors.add(:base, "Date time should be today or after todays date.") unless self.date_time >= Date.today.to_time
    if self.notification_type == 'Death'
      unless Notification.where("notification_type = 'Condolence' AND death_of = ? AND date_time < ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be before Date time of Condolence for #{self.death_of}.")
      end
    else
      unless Notification.where("notification_type = 'Death' AND death_of = ? AND date_time > ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be after Date time of Death for #{self.death_of}.")
      end
    end
  end
end
