require "test_helper"

class Sellers::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seller = sellers(:heisenberg)
    login_as(@seller, scope: :seller)

    @added_category = categories(:cement)
    @product = @seller.products.first
    @product_params = {
      location: @product.location,
      name: @product.name,
      price: @product.price,
      category_ids: [@added_category.id]
    }

    @other_product = products(:cement)
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference ['Product.count', '@seller.products.count'] do
      post products_url, params: { product: @product_params }
    end

    new_product = Product.last

    assert new_product.category_ids.include?(@added_category.id)
    assert_redirected_to product_url(new_product)
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: @product_params.merge({ category_ids: []}) }

    assert_equal @product.category_ids, []
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference ['Product.count', '@seller.products.count'], -1 do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "can only edit own product" do
    assert_raise ActiveRecord::RecordNotFound do
      get edit_product_url(@other_product)
    end
  end

  test "can only update own product" do
    assert_raise ActiveRecord::RecordNotFound do
      patch product_url(@other_product)
    end
  end

  test "can only delete own product" do
    assert_raise ActiveRecord::RecordNotFound do
      delete product_url(@other_product)
    end
  end

end
