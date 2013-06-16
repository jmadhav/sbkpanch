class StaticPagesController < ApplicationController
  def home
  end

  def notifications
   session[:notification_checked] =  true
   @death_notifications = Notification.where(:notification_type => 'Death').where("date_time > ?", Time.now).order('created_at DESC').page params[:page]
   @final_rights_notifications = Notification.where(:notification_type => 'Final Rights').where("date_time > ?", Time.now).order('created_at DESC').page params[:page]
   @condolence_notifications = Notification.where(:notification_type => 'Condolence').where("date_time > ?", Date.today.to_time).order('created_at DESC').page params[:page]
  end

  def activities
  end

  def events
    @events = Event.where('from_date_time > ?', Date.today.to_time).order('created_at ASC').page params[:page]
  end

  def about_us
  end

  def contact
    @visitor_mail = VisitorMail.new
  end
  
  def credits
  end
end
