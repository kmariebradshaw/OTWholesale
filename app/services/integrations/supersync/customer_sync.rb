# frozen_string_literal: true

require "base64"
require "net/http"
require "uri"
require "json"
require "securerandom"

module Integrations
  module Supersync
    class CustomerSync
      ENDPOINT = "https://supersync.cloud/webhook/v3/customer/7237".freeze
      SOURCE_SYSTEM = "oliverthomas_wholesale".freeze
      PACKET_TYPE = "customer_information".freeze

      def initialize(customer)
        @customer = customer
      end

      def call
        uri = URI.parse(ENDPOINT)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")

        request = Net::HTTP::Post.new(uri.request_uri)
        request["Content-Type"] = "application/json"

        token_id = Rails.application.credentials.dig(:netgain, :token_id)
        secret   = Rails.application.credentials.dig(:netgain, :secret)
        request.basic_auth(token_id, secret)

        request_payload = payload
        request.body = request_payload.to_json

        # Log outbound request (redact auth)
        Rails.logger.info({
          event: "third_party_request",
          endpoint: ENDPOINT,
          customer_id: @customer.id,
          request_id: request_payload[:request_id],
          headers: request.to_hash.except("authorization"),
          payload: request_payload
        }.to_json)

        response = http.request(request)

        Rails.logger.info({
          event: "third_party_response",
          endpoint: ENDPOINT,
          customer_id: @customer.id,
          request_id: request_payload[:request_id],
          status: response.code.to_i,
          body: response.body
        }.to_json)

        if response.is_a?(Net::HTTPSuccess)
          Rails.logger.info("[Netgain] Customer #{@customer.id} synced successfully")
        else
          Rails.logger.error("[Netgain] Error #{response.code}: #{response.body}")
        end

        response
      end

      private

      def payload
        {
          packet_type: PACKET_TYPE,
          request_id: SecureRandom.uuid,
          sent_at: Time.current.utc.iso8601,
          source_system: SOURCE_SYSTEM,
          customer: customer_payload
        }
      end

      def customer_payload
        data = {
          id: @customer.id,
          created_at: @customer.created_at&.utc&.iso8601,
          
          company: @customer.company,
          dba: @customer.dba,
          permit: @customer.permit,
          seller_permit_state: @customer.seller_permit_state,
          locations: @customer.locations,
          legal_status: @customer.legal_status,

          billing_addr: @customer.billing_addr,
          billing_ap: @customer.billing_ap,
          billing_city: @customer.billing_city,
          billing_state: @customer.billing_state,
          billing_zip: @customer.billing_zip,
          billing_phone: @customer.billing_phone,
          billing_email: @customer.billing_email.to_s,

          shipping_location: @customer.shipping_location,
          shipping_address: @customer.shipping_address,
          shipping_state: @customer.shipping_state,
          shipping_zip: @customer.shipping_zip,

          name: @customer.name,
          email: @customer.email.to_s,
          phone: @customer.phone,

          top3_1: @customer.top3_1,
          top3_2: @customer.top3_2,
          top3_3: @customer.top3_3,

          facebook: @customer.facebook,
          instagram: @customer.instagram,

          agree1: @customer.agree1,
          agree2: @customer.agree2,
          agree3: @customer.agree3,
          signed: @customer.signed,

          referral_source: @customer.referral_source,
          referral_source_other: @customer.referral_source_other,

          status: @customer.status,

          attachement: @customer.attachement&.url.to_s,
          employee_id: @customer.employee&.email.to_s,
          issues: @customer.issues,
          note: @customer.note
        }

        data.reject { |_, v| v.nil? || v == "" }
      end
    end
  end
end
