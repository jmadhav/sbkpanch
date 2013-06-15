class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :notification_check, :check_new_notifications
  #after_filter :store_location

  #def store_location
    # store last url as long as it isn't a /users path
  #  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/admins/
  #end

  def login_required   
    unless admin_signed_in? # calling devise generated method
      redirect_to new_admin_session_path
    end
  end

  def after_sign_in_path_for(resource)
    admins_dashboard_path
  end
  protected
    def check_new_notifications
      new_notification = Notification.where("date_time > ?", Date.today.to_time).order('date_time DESC').first
      unless new_notification.blank?
        if session[:new_notification] != new_notification.id
          session[:new_notification] = new_notification.id
          session[:notification_checked] = false
        end
      end
    end

    def notification_check
      unless session.has_key? :notification_checked
        session[:notification_checked] =  true
        session[:new_notification] = nil
      end
    end
end
