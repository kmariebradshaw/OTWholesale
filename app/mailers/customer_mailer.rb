class CustomerMailer < ApplicationMailer
  def new_customer_email
    @customer = params[:customer]

    mail(to: ENV['SEND_TO_GMAIL'], subject: "You got a new application from #{@customer.company}!")
  end
  def reject_customer_email
  	@customer = params[:customer]

    mail(to: @customer.email, subject: "A Message from Oliver Thomas")
  end
  def needs_final_approval_customer_email
  	  @customer = params[:customer]
  	  mail(to: ENV['SEND_TO_FINANCE'], subject: "A new application from #{@customer.company} needs your approval!")
  end 
end