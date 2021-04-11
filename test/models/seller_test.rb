require "test_helper"

class SellerTest < ActiveSupport::TestCase
  test "#orders should return orders that have line items that reference the seller's products" do
    seller = sellers(:jesse)
    assert_equal 1, seller.orders.ids.count
    assert_equal orders(:order_completed_by_homer), seller.orders.first
  end
end
