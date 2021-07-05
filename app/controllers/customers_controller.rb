class CustomersController < ApplicationController
  def new 
    @customer = Customer.new()
	end 
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer
    else
      render 'new'
    end 
  end 
  def show
    @customer = Customer.find(params[:id]) 
  end 
  def index
  
  end 
    def edit
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id]) 
     if @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end 
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    redirect_to root_path
  end
  private 
  def customer_params
      params.require(:customer).permit(:company, :dba, :permit, :seller_permit_state, :locations, :legal_status, :billing_addr, :billing_city, :billing_state, :billing_zip, :billing_ap, :billing_phone, :billing_email, :shipping_location, :shipping_address, :shipping_state, :shipping_zip, :name, :email, :phone, :top3_1, :top3_2, :top3_3, :facebook, :instagram, :agree1, :agree2, :signed, :referral_source, :referral_source_other, :status)
  end 
end

