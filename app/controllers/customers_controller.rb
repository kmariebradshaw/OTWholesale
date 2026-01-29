class CustomersController < ApplicationController
skip_before_action :authenticate_user!, only: [:new, :create,:index, :search]
  def new 
    @customer = Customer.new()
    @customer.attachement = params[:file]
	end 
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      CustomerMailer.with(customer: @customer).new_customer_email.deliver_later
      redirect_to '/customers'
    else
render :new, status: :unprocessable_entity
    end 
  end 
  def search
    if params[:search].blank?
    else
    @parameter = params[:search].downcase
    @results = Customer.all.where("lower(email) LIKE :search", search: "%#{@parameter}") 
    end 
  end 
  def show
    @customer = Customer.find(params[:id]) 
    @user = current_user 
    if params.has_key?(:'pdf')
      @pdf = true 
    else 
      @pdf = false 
    end 
  end 
  def index
    @customersdownload = Customer.all.order("created_at DESC")
      respond_to do |format|
    format.html
    format.csv { send_data @customersdownload.to_csv, filename: "Applications-#{Date.today}.csv" }
    end

  end 
    def edit
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id]) 
    @previous_status = @customer.status 
    @previous_rep = @customer.employee
    @previous_issues = @customer.issues  
     if @customer.update(customer_params)
      
      # issues update 
      if @previous_issues != @customer.issues
        CustomerMailer.with(customer: @customer).issues_customer_email.deliver_later
      end 

      # status update
      if @previous_status != @customer.status 
        if @customer.status == "Approved - Initial" 
          CustomerMailer.with(customer: @customer).needs_final_approval_customer_email.deliver_later
            new_customer = ShopifyAPI::Customer.new
            new_customer.first_name = @customer.name.split(' ').first
            new_customer.last_name = @customer.name.split(' ').last
            new_customer.email = @customer.email
            new_customer.phone = @customer.phone
            new_customer.save
            new_customer.addresses =[{"address1": @customer.shipping_address, "city": @customer.shipping_location, "zip": @customer.shipping_zip,"company": @customer.company, "phone": @customer.phone, "province": @customer.shipping_state, "country": "United States"}]
            new_customer.save

        elsif  @customer.status == "Repush to Shopify"
            new_customer = ShopifyAPI::Customer.new
            new_customer.first_name = @customer.name.split(' ').first
            new_customer.last_name = @customer.name.split(' ').last
            new_customer.email = @customer.email
            new_customer.phone = @customer.phone
            new_customer.save
            new_customer.addresses =[{"address1": @customer.shipping_address, "city": @customer.shipping_location, "zip": @customer.shipping_zip,"company": @customer.company, "phone": @customer.phone, "province": @customer.shipping_state, "country": "United States"}]
            new_customer.save
            @customer.status = @previous_status 
            @customer.save
          

        elsif  @customer.status == "Approved - Final"
          new_customer = ShopifyAPI::Customer.search(query: "email:#{@customer.email}")
          new_customer.first.send_invite
          trigger_netgain_sync(@customer)
          if @customer.employee 
            CustomerMailer.with(customer: @customer).rep_final_approval_customer_email.deliver_later
          end 
             

        elsif @customer.status == "Denied"
          CustomerMailer.with(customer: @customer).reject_customer_email.deliver_later
          trigger_netgain_sync(@customer)
          if @customer.employee 
            CustomerMailer.with(customer: @customer).rep_denial_customer_email.deliver_later
          end 
              

        
                elsif @customer.status == "Archived"

              redirect_to '/'
 
        end
      end 
        # rep update
      if @previous_rep != @customer.employee
        if @previous_rep 
        else 
          CustomerMailer.with(customer: @customer).assignment_customer_email.deliver_later
        end 
      end 

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
      params.require(:customer).permit(:attachement, :company, :dba, :permit, :seller_permit_state, :locations, :legal_status, :billing_addr, :billing_city, :billing_state, :billing_zip, :billing_ap, :billing_phone, :billing_email, :shipping_location, :shipping_address, :shipping_state, :shipping_zip, :name, :email, :phone, :top3_1, :top3_2, :top3_3, :facebook, :instagram, :agree1, :agree2, :signed, :referral_source, :referral_source_other, :status, :employee_id, :issues, :note)
  end 
  def trigger_netgain_sync(customer)
    Integrations::Supersync::CustomerSync.new(customer).call
  end
end

