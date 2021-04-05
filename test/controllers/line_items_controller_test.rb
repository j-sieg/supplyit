require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:guy_without_cart)
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

  test "should remove line items from the cart" do
    assert_difference ['LineItem.count'] do
      post line_items_url, params: { product_id: @product.id }
    end

    line_item = @user.cart.line_items.first

    assert_difference ['LineItem.count', '@user.cart.line_items.count'], -1 do
      delete line_item_url(line_item)
    end
  end

  test "should only reduce the quantity if quantity is more than one" do
    post line_items_url, params: { product_id: @product.id }
    post line_items_url, params: { product_id: @product.id }

    line_items = @user.cart.line_items
    assert_equal line_items.first.quantity, 2

    assert_no_difference ['LineItem.count', '@user.cart.line_items.count'] do
      delete line_item_url(line_items.first)
    end

    assert_equal line_items.reload.count, 1
    assert_equal line_items.first.quantity, 1
  end

  test "can only add line items of available products" do
    assert_raise ActiveRecord::RecordNotFound do
      post line_items_url, params: { product_id: products(:unavailable_product_from_walt) }
    end
  end

end
