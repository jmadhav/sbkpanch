class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate, :only => [:new, :create]
  
  def signup_landing
  end
  
  def after_inactive_sign_up_path_for(resource)
    '/admins/signup_landing'
  end

  protected
   def authenticate
     authenticate_or_request_with_http_basic do |username, password|
       username == 'admin'&& password == 'sbkpanch12345'
     end
   end
end
