require "application_system_test_case"

class User::CheckoutTest < ApplicationSystemTestCase
  setup do
    @user = users(:dane)
  end

  test "user loads cart, checks out, and orders" do
    user_login_as(@user)
    within "#current-cart-details" do
      assert_no_selector "a", text: "Checkout"
    end

    products = [products(:aggregate), products(:cement)]
    products.each do |product|
      within "article#product_#{product.id}" do
        assert_difference 'LineItem.count' do
          2.times { click_on 'add to cart' }
        end
      end
    end

    assert_equal 2, @user.cart.line_items.count

    @user.cart.line_items.each do |line_item|
      within '#current-cart-details' do
        assert_line_item(line_item)
      end
    end

    within "#current-cart-details" do
      assert_selector "a", text: "Checkout"
      click_on "Checkout"
    end

    within '#checkout-form' do
      select Order.pay_types.keys.last, from: 'order_pay_type'
      click_on "Pay"
    end

    assert_difference '@user.orders.count' do
      click_on "Confirm"
    end

    new_order = @user.orders.last
    assert_text "Successfully created your order"
    assert_order_item(new_order)
    assert_equal Order.pay_types.keys.last, new_order.pay_type
  end
end
