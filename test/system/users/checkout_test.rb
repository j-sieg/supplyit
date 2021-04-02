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

    click_on "Pay"
    assert_difference '@user.orders.count' do
      click_on "Confirm"
    end

    assert_text "Successfully created your order"
    assert_order_item(@user.orders.last)
  end
end
