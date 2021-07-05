class WelcomeController < ApplicationController
  def index
  	@pending_customers = Customer.all.where(:status => "pending")

  end
end
