class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
   	  t.string :company,null: false
   	  t.string :dba
   	  t.string :permit,null: false
   	  t.string :seller_permit_state, null: false
   	  t.integer :locations
   	  t.string :legal_status, null: false
   	  t.string :billing_addr, null: false
   	  t.string :billing_city, null: false
   	  t.string :billing_state, null: false
   	  t.string :billing_zip, null: false
   	  t.string :billing_ap, null: false
	  t.string :billing_phone
	  t.string :billing_email, null: false
	  t.string :shipping_location
	  t.string :shipping_address
	  t.string :shipping_state
	  t.string :shipping_zip
	  t.string :name, null: false
	  t.string :email, null: false
	  t.string :phone, null: false
	  t.string :top3_1
	  t.string :top3_2
	  t.string :top3_3
	  t.string :facebook
	  t.string :instagram
	  t.boolean :agree1, null: false
	  t.boolean :agree2, null: false
	  t.boolean :signed
	  t.string :referral_source
	  t.string :referral_source_other
      t.string :status, default: "pending"
      t.timestamps
    end
  end
end
