class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:show]

  def index
  	@pending_customers = Customer.all.where(:status => "pending").order("created_at DESC")
  	@decision_customers = Customer.all.where.not(:status => "pending").order("created_at DESC")
  end
  def show
  	@customers = Customer.all
  	 if params[:search_by_email]  != ""
      @searched_email = @customers.where("email", 
      "%# {params[:search_by_email]}%")
    end
    
  end 
end
