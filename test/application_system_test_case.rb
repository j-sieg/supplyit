require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActionView::Helpers
  include ApplicationHelper
  driven_by :selenium, using: :firefox, screen_size: [1400, 1400]

  def seller_login_as(seller)
    email =
      case seller when Symbol then sellers(seller).email
      else seller.email
      end

    visit new_seller_session_path
    fill_in "Email", with: email
    fill_in "Password", with: "Metamphetam1n3!"
    click_on "Log in"
  end

  def user_login_as(user)
    email =
      case user when Symbol then users(user).email
      else user.email
      end

    visit new_user_session_path
    fill_in "Email", with: email
    fill_in "Password", with: "1supersecret!"
    click_on "Log in"
  end

  def assert_line_item(line_item)
    dom_id = "item_#{line_item.id}"
    assert_selector 'tr', id: dom_id

    within "##{dom_id}" do
      assert_selector 'td', text: line_item.product.name
      assert_selector 'td', text: line_item.price
      assert_selector 'td', text: line_item.quantity
    end
  end

  def assert_order_item(order)
    dom_id = "order_#{order.id}"
    assert_selector 'tr', id: dom_id
    within "##{dom_id}" do
      assert_selector 'td', text: "Order##{order.id}"
      assert_selector 'td', text: formatted_time(order.created_at)
      assert_selector 'td', text: order.status
      assert_selector 'td', text: price_format(order.total_cost)
    end
  end
end
