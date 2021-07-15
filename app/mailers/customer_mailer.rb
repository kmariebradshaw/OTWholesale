class CustomerMailer < ApplicationMailer
  def new_customer_email
    @customer = params[:customer]

    mail(to: 'kaitlynmbradshaw@gmail.com', subject: "You got a new application!")
  end
end