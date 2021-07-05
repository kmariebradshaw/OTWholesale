class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
   	  t.string :company
   	  t.string :dba
   	  t.string :permit
   	  t.string :seller_permit_state
   	  t.integer :locations
   	  t.string :legal_status
   	  t.string :billing_addr
   	  t.string :billing_city
   	  t.string :billing_state
   	  t.string :billing_zip
   	  t.string :billing_ap
	  t.string :billing_phone
	  t.string :billing_email
	  t.string :shipping_location
	  t.string :shipping_address
	  t.string :shipping_state
	  t.string :shipping_zip
	  t.string :name
	  t.string :email
	  t.string :phone
	  t.string :top3_1
	  t.string :top3_2
	  t.string :top3_3
	  t.string :facebook
	  t.string :instagram
	  t.boolean :agree1
	  t.boolean :agree2
	  t.boolean :signed
	  t.string :referral_source
	  t.string :referral_source_other
      t.string :status, default: "pending"
      t.timestamps
    end
  end
end
