class CustomersController < ApplicationController
skip_before_action :authenticate_user!, only: [:new, :create,:index]
  def new 
    @customer = Customer.new()
	end 
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      CustomerMailer.with(customer: @customer).new_customer_email.deliver_later
      redirect_to '/customers'
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
      if @customer.status == "Approved"
        new_customer = ShopifyAPI::Customer.new
        new_customer.first_name = @customer.company
        new_customer.last_name = @customer.name
        new_customer.email = @customer.email
        new_customer.phone = @customer.phone
        new_customer.address1 = @customer.shipping_address
        new_customer.city = @customer.shipping_location
        new_customer.province = @customer.shipping_state
        new_customer.zip = @customer.shipping_zip
        new_customer.send_email_invite = true 
        if new_customer.save 
          puts "saved"
        else 
          puts "error"
        end 
      elsif @customer.status == "Denied"
        CustomerMailer.with(customer: @customer).reject_customer_email.deliver_later
      end 
      redirect_to @customer
    else
      render :edit
    end
  end 
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    puts 'hit path'
    redirect_to root_path
  end
  private 
  def customer_params
      params.require(:customer).permit(:attachement, :company, :dba, :permit, :seller_permit_state, :locations, :legal_status, :billing_addr, :billing_city, :billing_state, :billing_zip, :billing_ap, :billing_phone, :billing_email, :shipping_location, :shipping_address, :shipping_state, :shipping_zip, :name, :email, :phone, :top3_1, :top3_2, :top3_3, :facebook, :instagram, :agree1, :agree2, :signed, :referral_source, :referral_source_other, :status)
  end 
end

