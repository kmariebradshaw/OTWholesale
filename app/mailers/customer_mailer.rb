class CustomerMailer < ApplicationMailer
  def new_customer_email
    @customer = params[:customer]

    mail(to: ENV['SEND_TO_GMAIL'], subject: "Wholesale: New Application from #{@customer.company}!", :cc => "customerservice@theoliverthomas.com")
  end
  def reject_customer_email
  	@customer = params[:customer]
    attachments.inline["paw-heart-print.png"] = File.read("#{Rails.root}/app/assets/images/paw-heart-print.png")
    mail(to: @customer.email, subject: "A Message from Oliver Thomas")
  end
  def issues_customer_email
    @customer = params[:customer]
    attachments.inline["paw-heart-print.png"] = File.read("#{Rails.root}/app/assets/images/paw-heart-print.png")
    if @customer.employee
    mail(to: @customer.email, subject: "Issues with Your Oliver Thomas Application", :cc => @customer.employee.email )
  else 
        mail(to: @customer.email, subject: "Issues with Your Oliver Thomas Application", :cc => "customerservice@theoliverthomas.com" )
       end 
  end 
  def needs_final_approval_customer_email
  	  @customer = params[:customer]
  	  mail(to: ENV['SEND_TO_FINANCE'], subject: "A New Application from #{@customer.company} Needs Your Approval.")
  end 
  def assignment_customer_email
    @customer = params[:customer]
    mail(to: @customer.employee.email, subject: "New Assigned Customer: #{@customer.company}")
  end

  def rep_final_approval_customer_email
    @customer = params[:customer]
    if @customer.employee
      mail(to: @customer.employee.email, subject: "#{@customer.company}'s Application  Has a Status Update - Final Approval", :cc => "sfuller@theoliverthomas.com" )
    end 
  end
  def rep_denial_customer_email
    @customer = params[:customer]
    mail(to: @customer.employee.email, subject: "#{@customer.company}'s Application Has a Status Update - Denied")
  end
end