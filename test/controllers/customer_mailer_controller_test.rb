require "test_helper"

class CustomerMailerControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
    def new_order_email
    @customer = Customer.new(name: "Joe Smith", email: "joe@gmail.com", address: "1-2-3 Chuo, Tokyo, 333-0000", phone: "090-7777-8888", message: "I want to place an order!")

    CustomerMailer.with(customer: @customer).new_customer_email
  end
end
