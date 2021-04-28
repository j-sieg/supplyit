require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "#total_cost returns the sum of items total_cost in the order" do
    order = orders(:homer_buys_from_jesse)
    assert_equal 5000, order.total_cost

    order = orders(:darwin_buys_from_jesse_and_heisenberg)
    assert_equal 1500, order.total_cost
  end

  test "#total_cost returns the sum of the items scoped to a seller" do
    jesse = sellers(:jesse)
    order = orders(:darwin_buys_from_jesse_and_heisenberg)
    order = Order.with_items_from(seller: jesse).find(order.id)

    assert_equal 1000, order.total_cost


    heisenberg = sellers(:heisenberg)
    order = orders(:darwin_buys_from_jesse_and_heisenberg)
    order = Order.with_items_from(seller: heisenberg).find(order.id)

    assert_equal 500, order.total_cost
  end
end
