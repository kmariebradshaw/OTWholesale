class WelcomeController < ApplicationController
    before_action :authenticate_user!
  def index
  	@pending_customers = Customer.all.where(:status => "pending")
  	@decision_customers = Customer.all.where.not(:status => "pending")
  end
end
