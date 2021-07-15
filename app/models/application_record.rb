class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOP_NAME']}.myshopify.com"
  ShopifyAPI::Base.site = shop_url
  ShopifyAPI::Base.api_version = '2021-07'
end
