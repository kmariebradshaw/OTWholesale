class WelcomeController < ApplicationController
  def index
  	@pending_customers = Customer.all.where(:status => "pending")
  	@decision_customers = Customer.all.where.not(:status => "pending")
  end
end
