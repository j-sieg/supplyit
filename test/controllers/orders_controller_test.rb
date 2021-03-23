require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @completed_order = orders(:order_completed_by_homer)
    @product = products(:cement)
  end

  test "should get index only when authenticated" do
    get orders_url
    assert_redirected_to new_user_session_url

    login_as(users(:darwin), scope: :user)
    get orders_url
    assert_response :success
  end

  test "should get show only when authenticated" do
    get order_url(@completed_order)
    assert_redirected_to new_user_session_url

    login_as(users(:homer), scope: :user)
    get order_url(@completed_order)
    assert_response :success
  end

  test "can only access owned order" do
    login_as(users(:darwin), scope: :user)
    assert_raise ActiveRecord::RecordNotFound do
      get order_url(@completed_order)
    end
  end

  test "should only create an order when authenticated" do
    post orders_url
    assert_redirected_to new_user_session_url

    user = users(:darwin)
    login_as(user, scope: :user)
    assert_difference ['user.orders.count', 'Order.count'] do
      post orders_url
    end
  end

  test "cannot create an order when cart is empty" do
    login_as(users(:dane), scope: :user)
    post orders_url
    assert_redirected_to products_url
    assert_not_nil flash[:notice]
  end

end
