require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActionView::Helpers::NumberHelper
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
    line_item_id = dom_id(line_item)
    assert_selector 'tr', id: line_item_id

    within "##{line_item_id}" do
      assert_selector 'td', text: line_item.product.name
      assert_selector 'td', text: line_item.price
      assert_selector 'td', text: line_item.quantity
    end
  end

  def assert_no_line_item(line_item)
    assert_no_selector 'tr', id: dom_id(line_item)
  end

  def assert_order_item(order)
    order_item_id = dom_id(order)
    assert_selector 'tr', id: order_item_id

    within "##{order_item_id}" do
      assert_selector 'td', text: "Order##{order.id}"
      assert_selector 'td', text: formatted_time(order.created_at)
      assert_selector 'td', text: order.status
      assert_selector 'td', text: price_format(order.total_cost)
    end
  end
end
