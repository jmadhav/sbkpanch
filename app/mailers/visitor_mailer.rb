class VisitorMailer < ActionMailer::Base
  default from: "SBKPanch Web Admin <webadmin@sbkpanch.com>"

  def mail_to_committee visitor_name, visitor_email, visitor_mobile, to_emails, cc_email, bcc_email, subject, message
    @visitor_name, @visitor_email, @visitor_mobile, @message = visitor_name, visitor_email, visitor_mobile, message
    mail(:from => visitor_name + "<#{visitor_email}>", :to => to_emails, :cc_email => cc_email, :bcc_email => bcc_email, :subject => subject)
  end

  
  def default_reply_to_visitor visitor_name, visitor_email, to_emails, cc_email, bcc_email, subject
    @visitor_name, @to_emails, @subject = visitor_name, to_emails, subject
    mail( :to => visitor_name + "<#{visitor_email}>" , :bcc_email => "SBKPanch Web Admin <webadmin@sbkpanch.com>", :subject => subject)
  end
end
