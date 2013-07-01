class VisitorMailSubjectsController < ApplicationController

  before_filter  :login_required

  # GET /visitor_mail_subjects
  # GET /visitor_mail_subjects.json
  def index
    @visitor_mail_subjects = VisitorMailSubject.order('created_at DESC').page params[:page]
  end

  # GET /visitor_mail_subjects/1
  # GET /visitor_mail_subjects/1.json
  def show
    @visitor_mail_subject = VisitorMailSubject.find(params[:id])
  end

  # GET /visitor_mail_subjects/new
  # GET /visitor_mail_subjects/new.json
  def new
    @visitor_mail_subject = VisitorMailSubject.new
  end

  # GET /visitor_mail_subjects/1/edit
  def edit
    @visitor_mail_subject = VisitorMailSubject.find(params[:id])
  end

  # POST /visitor_mail_subjects
  # POST /visitor_mail_subjects.json
  def create
    @visitor_mail_subject = VisitorMailSubject.new(params[:visitor_mail_subject])
    @visitor_mail_subject.created_by = current_admin.email
    @visitor_mail_subject.updated_by = current_admin.email

    if @visitor_mail_subject.save
      redirect_to visitor_mail_subjects_url, notice: 'Visitor mail subject was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /visitor_mail_subjects/1
  # PUT /visitor_mail_subjects/1.json
  def update
    @visitor_mail_subject = VisitorMailSubject.find(params[:id])
    @visitor_mail_subject.updated_by = current_admin.email
    if @visitor_mail_subject.update_attributes(params[:visitor_mail_subject])
      redirect_to visitor_mail_subjects_url, notice: 'Visitor mail subject was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /visitor_mail_subjects/1
  # DELETE /visitor_mail_subjects/1.json
  def destroy
    @visitor_mail_subject = VisitorMailSubject.find(params[:id])
    @visitor_mail_subject.disabled = true
    @visitor_mail_subject.save

    redirect_to visitor_mail_subjects_url
  end
end
