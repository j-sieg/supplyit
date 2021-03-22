require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:darwin)
    @product = products(:cement)
    @other_product = products(:aggregate)
    login_as(@user, scope: :user)
  end

  test "should add line items to cart based on product_id" do
    assert_difference ['LineItem.count'] do
      post line_items_url, params: { product_id: @product.id }
    end

    assert_difference ['LineItem.count'] do
      post line_items_url, params: { product_id: @other_product.id }
    end
  end

  test "increase quantity of item in cart with the same product_id" do
    assert_difference ['LineItem.count'] do
      post line_items_url, params: { product_id: @product.id }
    end

    assert_no_difference ['LineItem.count'] do
      post line_items_url, params: { product_id: @product.id }
    end

    assert_equal @user.cart.line_items.first.quantity, 2
  end

end
