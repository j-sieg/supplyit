require "test_helper"

class SellerTest < ActiveSupport::TestCase
  test "#orders should return orders that have line items that reference the seller's products" do
    seller = sellers(:jesse)
    assert_equal([],
      [
        orders(:homer_buys_from_jesse).id,
        orders(:darwin_buys_from_jesse_and_heisenberg).id
      ] - seller.orders.ids
    )
  end
end
