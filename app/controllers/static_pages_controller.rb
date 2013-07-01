class StaticPagesController < ApplicationController
  def home
  end

  def notifications
   session[:notification_checked] =  true
   @notifications = Notification.where("date_time > ? OR (notification_type = 'Sad Demise' AND hide = ?)", Date.today.to_time, false).order('created_at DESC').page params[:page]   
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
