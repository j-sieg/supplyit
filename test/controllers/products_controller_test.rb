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

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end
end
