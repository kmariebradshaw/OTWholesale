require 'csv'
require 'carrierwave/orm/activerecord'

class Customer < ApplicationRecord
	belongs_to :employee
	mount_uploader :attachement, AttachmentUploader 
  validates :billing_phone, phone: true

	def self.to_csv
    CSV.generate do |csv|
      csv << %w{ company dba permit seller_permit_state locations legal_status billing_addr billing_city billing_state billing_zip billing_ap billing_phone billing_email shipping_address shipping_city shipping_state shipping_zip name email billing_phone top3_1 top3_2 top3_3 facebook instagram agree1 agree2 referral_source referral_source_other status created_at } 
      all.each do |customer|
        csv << [customer.company, customer.dba, customer.permit, customer.seller_permit_state, customer.locations, customer.legal_status, customer.billing_addr, customer.billing_city, customer.billing_state, customer.billing_zip, customer.billing_ap, customer.billing_phone, customer.billing_email, customer.shipping_address, customer.shipping_location, customer.shipping_state, customer.shipping_zip, customer.name, customer.email, customer.billing_phone, customer.top3_1, customer.top3_2, customer.top3_3, customer.facebook, customer.instagram, customer.agree1, customer.agree2, customer.referral_source, customer.referral_source_other, customer.status, customer.created_at ]
      end
    end
  end
end
