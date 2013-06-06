class VisitorMailSubjectsController < ApplicationController

  before_filter  :login_required

  # GET /visitor_mail_subjects
  # GET /visitor_mail_subjects.json
  def index
    @visitor_mail_subjects = VisitorMailSubject.order('created_at DESC').page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visitor_mail_subjects }
    end
  end

  # GET /visitor_mail_subjects/1
  # GET /visitor_mail_subjects/1.json
  def show
    @visitor_mail_subject = VisitorMailSubject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @visitor_mail_subject }
    end
  end

  # GET /visitor_mail_subjects/new
  # GET /visitor_mail_subjects/new.json
  def new
    @visitor_mail_subject = VisitorMailSubject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @visitor_mail_subject }
    end
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

    respond_to do |format|
      if @visitor_mail_subject.save
        format.html { redirect_to @visitor_mail_subject, notice: 'Visitor mail subject was successfully created.' }
        format.json { render json: @visitor_mail_subject, status: :created, location: @visitor_mail_subject }
      else
        format.html { render action: "new" }
        format.json { render json: @visitor_mail_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /visitor_mail_subjects/1
  # PUT /visitor_mail_subjects/1.json
  def update
    @visitor_mail_subject = VisitorMailSubject.find(params[:id])
    @visitor_mail_subject.updated_by = current_admin.email
    respond_to do |format|
      if @visitor_mail_subject.update_attributes(params[:visitor_mail_subject])
        format.html { redirect_to @visitor_mail_subject, notice: 'Visitor mail subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @visitor_mail_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitor_mail_subjects/1
  # DELETE /visitor_mail_subjects/1.json
  def destroy
    @visitor_mail_subject = VisitorMailSubject.find(params[:id])
    @visitor_mail_subject.disabled = true
    @visitor_mail_subject.save

    respond_to do |format|
      format.html { redirect_to visitor_mail_subjects_url }
      format.json { head :no_content }
    end
  end
end
