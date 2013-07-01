class Notification < ActiveRecord::Base
  attr_accessible :date_time, :notification_type, :death_of, :address, :sad_demise_id, :created_by, :updated_by
  
  # Default Scope
  default_scope where( :disabled => false)

  # Validations
  validates_presence_of :date_time, :notification_type, :death_of, :address, :created_by, :updated_by
  validates_uniqueness_of :death_of, :scope => :notification_type
  validates_uniqueness_of :sad_demise_id, :scope => :disabled, :allow_nil => true
  validates_inclusion_of :notification_type, in: ["Sad Demise", "Final Rites", "Condolence Meeting"]
  validates_inclusion_of :disabled, :hide, in: [true, false]
  
  validate :validate_date_time, :validate_notification_type_and_sad_demise_id

  def validate_date_time
    return self.errors.add(:base, "Date time should be today or after todays date.") if self.date_time < Date.today.to_time and self.notification_type != 'Sad Demise'
    return self.errors.add(:base, "Date time should be not more than 2 todays back.") if self.date_time < (Date.today.to_time - 2.days) and self.notification_type == 'Sad Demise'
    if self.notification_type == 'Sad Demise'
      unless Notification.where("notification_type = 'Final Rites' AND death_of = ? AND date_time < ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be before Date time of Final Rites for #{self.death_of}.")
      end
      unless Notification.where("notification_type = 'Condolence Meeting' AND death_of = ? AND date_time < ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be before Date time of Condolence Meeting for #{self.death_of}.")
      end
    elsif self.notification_type == 'Final Rites'
      unless Notification.where("notification_type = 'Sad Demise' AND death_of = ? AND date_time > ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be after Date time of Sad Demise for #{self.death_of}.")
      end
      unless Notification.where("notification_type = 'Condolence Meeting' AND death_of = ? AND date_time < ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be before Date time of Condolence Meeting for #{self.death_of}.")
      end
    else
      unless Notification.where("notification_type = 'Final Rites' AND death_of = ? AND date_time > ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be after Date time of Final Rites for #{self.death_of}.")
      end
      unless Notification.where("notification_type = 'Sad Demise' AND death_of = ? AND date_time > ?", self.death_of, self.date_time).blank?
        return self.errors.add(:base, "Current Date time should be after Date time of Sad Demise for #{self.death_of}.")
      end
    end
  end

  def validate_notification_type_and_sad_demise_id
    if self.notification_type == 'Final Rites'
      return self.errors.add(:base, "There is no Reference for Sad Demise.") if self.sad_demise_id.blank?
      notification = Notification.find(self.sad_demise_id)
      return self.errors.add(:base, "The Reference referring to #{notification.notification_type} rather than Sad Demise.") unless notification.notification_type == 'Sad Demise'
    end
  end
end
