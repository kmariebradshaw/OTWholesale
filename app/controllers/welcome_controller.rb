class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:show]

  def index
  	@pending_customers = Customer.all.where(:status => "pending")
  	@decision_customers = Customer.all.where.not(:status => "pending")
  end
  def show
  	@employee = Employee.new 
  end 
end
