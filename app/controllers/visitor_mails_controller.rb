class VisitorMailsController < ApplicationController
  
  before_filter  :login_required
  
  # GET /visitor_mails
  # GET /visitor_mails.json
  def index
    @visitor_mails = VisitorMail.order('created_at DESC').page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visitor_mails }
    end
  end

  # GET /visitor_mails/1
  # GET /visitor_mails/1.json
  def show
    @visitor_mail = VisitorMail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @visitor_mail }
    end
  end

  # GET /visitor_mails/new
  # GET /visitor_mails/new.json
  def new
    @visitor_mail = VisitorMail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @visitor_mail }
    end
  end

  # GET /visitor_mails/1/edit
  def edit
    @visitor_mail = VisitorMail.find(params[:id])
  end

  # POST /visitor_mails
  # POST /visitor_mails.json
  def create
    @visitor_mail = VisitorMail.new(params[:visitor_mail])
    @visitor_mail.created_by = current_admin.email
    @visitor_mail.updated_by = current_admin.email

    respond_to do |format|
      if @visitor_mail.save
        format.html { redirect_to @visitor_mail, notice: 'Visitor mail was successfully created.' }
        format.json { render json: @visitor_mail, status: :created, location: @visitor_mail }
      else
        format.html { render action: "new" }
        format.json { render json: @visitor_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /visitor_mails/1
  # PUT /visitor_mails/1.json
  def update
    @visitor_mail = VisitorMail.find(params[:id])
    @visitor_mail.updated_by = current_admin.email
    respond_to do |format|
      if @visitor_mail.update_attributes(params[:visitor_mail])
        format.html { redirect_to @visitor_mail, notice: 'Visitor mail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @visitor_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitor_mails/1
  # DELETE /visitor_mails/1.json
  def destroy
    @visitor_mail = VisitorMail.find(params[:id])
    @visitor_mail.disabled = true
    @visitor_mail.save

    respond_to do |format|
      format.html { redirect_to visitor_mails_url }
      format.json { head :no_content }
    end
  end
end
