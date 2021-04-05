require "application_system_test_case"

class CartTest < ApplicationSystemTestCase

  test "adding and removing items from cart" do
    @user = users(:dane)
    user_login_as(@user)

    Product.available.limit(3).order('RANDOM()').each do |product|
      within "##{dom_id(product)}" do
        assert_difference('LineItem.count') do
          2.times { click_on 'add to cart' }
        end
      end
    end

    @user.cart.line_items.each do |line_item|
      assert_line_item(line_item)
    end

    line_item = @user.cart.line_items.first

    within "##{dom_id(line_item)}" do
      assert_no_difference 'LineItem.count' do
        click_on 'remove'
      end

      line_item.reload
      assert_equal 1, line_item.quantity

      assert_difference 'LineItem.count', -1 do
        click_on 'remove'
      end
    end

    assert_no_line_item line_item
  end

  test "emptying a cart" do
    @user = users(:darwin)
    user_login_as(@user)
    cart = @user.cart

    within "#current-cart-details" do
      click_on "Empty cart"
    end

    assert_difference 'Cart.count', -1 do
      click_on "Empty my cart"
    end
  end

end
