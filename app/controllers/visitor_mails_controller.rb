class VisitorMailsController < ApplicationController
  
  before_filter  :login_required, :except => [:create]
  
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
    @visitor_mail.created_by = params[:visitor_mail][:from_email] #current_admin.email
    @visitor_mail.updated_by = params[:visitor_mail][:from_email] #current_admin.email
    visitor_mail_subject = VisitorMailSubject.find(params[:visitor_mail][:visitor_mail_subject_id])
    committee_emails = get_committee_emails visitor_mail_subject
    send_corresponding_mails committee_emails, visitor_mail_subject, params[:visitor_mail]
    @visitor_mail.to_emails = get_to_emails committee_emails
    respond_to do |format|
      if @visitor_mail.save
        format.html { redirect_to contact_path, notice: 'Thanks for writing to us. Your Email has been sent to concerned person. Please check your inbox for confirmation of email.' }
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

  protected

  def get_to_emails committee_emails
    to_emails = ""
    committee_emails.each do|k, v|
      to_emails = to_emails + "#{k} => [#{v.join(',')}]"
    end
    to_emails
  end

  def get_committee_emails visitor_mail_subject
    committee_emails = {}
    visitor_mail_subject.subject_email_details.each do|d|
      committee_email = CommitteeEmail.find(d.committee_email_id)
      committee_emails[d.receiver_type] << "#{committee_email.person} <#{committee_email.email}>" if committee_emails.has_key? d.receiver_type
      committee_emails[d.receiver_type] = ["#{committee_email.person} <#{committee_email.email}>"] unless committee_emails.has_key? d.receiver_type
    end
    committee_emails
  end

  def send_corresponding_mails committee_emails, visitor_mail_subject,visitor_mail
    to_emails = committee_emails["To:"]
    cc_email  = committee_emails["Cc:"].blank? ? nil : committee_emails["Cc:"].first
    bcc_email = committee_emails["Bcc:"].blank? ? nil : committee_emails["Bcc:"].first
    VisitorMailer.mail_to_committee(visitor_mail[:from_name], visitor_mail[:from_email], visitor_mail[:from_mobile], to_emails, cc_email, bcc_email, visitor_mail_subject.subject, visitor_mail[:message]).deliver
    VisitorMailer.default_reply_to_visitor(visitor_mail[:from_name], visitor_mail[:from_email], to_emails, cc_email, bcc_email, visitor_mail_subject.subject).deliver
  end
end
