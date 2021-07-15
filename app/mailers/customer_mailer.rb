class CustomerMailer < ApplicationMailer
  def new_customer_email
    @customer = params[:customer]

    mail(to: ENV['SEND_TO_GMAIL'], subject: "You got a new application!")
  end
end