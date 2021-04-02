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

  test "should make the unassigned cart belong to the user once logged in" do
    get products_url
    cart_id = session[:cart_id]

    user = users(:guy_without_cart)
    login_as(user, scope: :user)

    get products_url
    assert_equal user.cart.id, cart_id
  end

  test "should not set the unassigned cart to a user that already has one" do
    get products_url
    cart_id = session[:cart_id]

    user = users(:dane)
    login_as(user, scope: :user)

    get products_url
    assert_not_equal user.cart.id, cart_id
  end

end
