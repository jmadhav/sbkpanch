class CommitteeEmailsController < ApplicationController
  
  before_filter  :login_required
  
  # GET /committee_emails
  # GET /committee_emails.json
  def index
    @committee_emails = CommitteeEmail.order('created_at DESC').page params[:page]
  end

  # GET /committee_emails/1
  # GET /committee_emails/1.json
  def show
    @committee_email = CommitteeEmail.find(params[:id])
  end

  # GET /committee_emails/new
  # GET /committee_emails/new.json
  def new
    @committee_email = CommitteeEmail.new
  end

  # GET /committee_emails/1/edit
  def edit
    @committee_email = CommitteeEmail.find(params[:id])
  end

  # POST /committee_emails
  # POST /committee_emails.json
  def create
    @committee_email = CommitteeEmail.new(params[:committee_email])
    @committee_email.created_by = current_admin.email
    @committee_email.updated_by = current_admin.email
    if @committee_email.save
      redirect_to committee_emails_url, notice: 'Committee email was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /committee_emails/1
  # PUT /committee_emails/1.json
  def update
    @committee_email = CommitteeEmail.find(params[:id])
    @committee_email.updated_by = current_admin.email
    if @committee_email.update_attributes(params[:committee_email])
      redirect_to committee_emails_url, notice: 'Committee email was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /committee_emails/1
  # DELETE /committee_emails/1.json
  def destroy
    @committee_email = CommitteeEmail.find(params[:id])
    @committee_email.disabled = true
    @committee_email.save

    redirect_to committee_emails_url
  end
end
