class CommitteeEmailsController < ApplicationController
  
  before_filter  :login_required
  
  # GET /committee_emails
  # GET /committee_emails.json
  def index
    @committee_emails = CommitteeEmail.order('created_at DESC').page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @committee_emails }
    end
  end

  # GET /committee_emails/1
  # GET /committee_emails/1.json
  def show
    @committee_email = CommitteeEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @committee_email }
    end
  end

  # GET /committee_emails/new
  # GET /committee_emails/new.json
  def new
    @committee_email = CommitteeEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @committee_email }
    end
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
    respond_to do |format|
      if @committee_email.save
        format.html { redirect_to @committee_email, notice: 'Committee email was successfully created.' }
        format.json { render json: @committee_email, status: :created, location: @committee_email }
      else
        format.html { render action: "new" }
        format.json { render json: @committee_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /committee_emails/1
  # PUT /committee_emails/1.json
  def update
    @committee_email = CommitteeEmail.find(params[:id])
    @committee_email.updated_by = current_admin.email
    respond_to do |format|
      if @committee_email.update_attributes(params[:committee_email])
        format.html { redirect_to @committee_email, notice: 'Committee email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @committee_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committee_emails/1
  # DELETE /committee_emails/1.json
  def destroy
    @committee_email = CommitteeEmail.find(params[:id])
    @committee_email.disabled = true
    @committee_email.save

    respond_to do |format|
      format.html { redirect_to committee_emails_url }
      format.json { head :no_content }
    end
  end
end
