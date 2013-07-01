class NotificationsController < ApplicationController
  
  before_filter  :login_required
  
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.order('created_at DESC').page params[:page]
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])
  end

  # GET /notifications/new
  # GET /notifications/new.json
  def new
    if params[:notification_type]
      old_record = Notification.find(params[:id])
      @notification = old_record.dup
      @notification.notification_type = params[:notification_type]
      if params[:notification_type] == 'Final Rites'
        @notification.sad_demise_id = old_record.id
      else
        @notification.sad_demise_id = nil
      end
    else
      @notification = Notification.new
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(params[:notification])
    @notification.created_by = current_admin.email
    @notification.updated_by = current_admin.email
    if @notification.save
      unless params[:notification][:sad_demise_id].blank?
        old_record = Notification.find(params[:notification][:sad_demise_id])
        old_record.hide = true
        old_record.save
      end
      redirect_to @notification, notice: 'Notification was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.json
  def update
    @notification = Notification.find(params[:id])
    @notification.updated_by = current_admin.email
    if @notification.update_attributes(params[:notification])
      redirect_to @notification, notice: 'Notification was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.disabled = true
    @notification.save
    redirect_to notifications_url
  end
end
