require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @added_category = categories(:cement)
    @product = products(:aggregate)
    @product_params = {
      location: @product.location,
      name: @product.name,
      price: @product.price,
      category_ids: [@added_category.id]
    }
  end

  test "should get index and set a cart from session" do
    get products_url
    assert_response :success
    assert_not_nil session[:cart_id]
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should set the cart to a logged in user without a cart" do
    get products_url
    cart_id = session[:cart_id]

    user = users(:darwin)
    login_as(user, scope: :user)

    get products_url
    assert_equal user.cart.id, cart_id
  end

  test "should not set the cart when a user has a cart" do
    get products_url
    cart_id = session[:cart_id]

    user = users(:dane)
    login_as(user, scope: :user)

    get products_url
    assert_not_equal user.cart.id, cart_id
  end

end
