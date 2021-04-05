require "test_helper"

class Sellers::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seller = sellers(:heisenberg)
    login_as(@seller, scope: :seller)

    @added_category = categories(:cement)
    @product = products(:aggregate)
    @product_params = {
      location: @product.location,
      name: @product.name,
      price: @product.price,
      category_ids: [@added_category.id]
    }

    @other_product = products(:cement)
  end

  test "should get new" do
    get new_sellers_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference ['Product.count', '@seller.products.count'] do
      post sellers_products_url, params: { product: @product_params }
    end

    new_product = Product.last

    assert new_product.category_ids.include?(@added_category.id)
    assert_redirected_to sellers_product_url(new_product)
  end

  test "should get edit" do
    get edit_sellers_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch sellers_product_url(@product), params: {
      product: @product_params.merge({ available: false, category_ids: [] })
    }

    @product.reload
    assert_not @product.available
    assert_equal @product.category_ids, []
    assert_redirected_to sellers_product_url(@product)
  end

  test "cannot destroy product with line items" do
    assert_no_difference ['Product.count', '@seller.products.count'] do
      delete sellers_product_url(@product)
    end
    assert_redirected_to sellers_products_url
  end

  test "should destroy product" do
    assert_difference ['Product.count', '@seller.products.count'], -1 do
      delete sellers_product_url(products(:destroyable_product_from_walt))
    end
    assert_redirected_to sellers_products_url
  end

  test "can only edit own product" do
    assert_raise ActiveRecord::RecordNotFound do
      get edit_sellers_product_url(@other_product)
    end
  end

  test "can only update own product" do
    assert_raise ActiveRecord::RecordNotFound do
      patch sellers_product_url(@other_product)
    end
  end

  test "can only delete own product" do
    assert_raise ActiveRecord::RecordNotFound do
      delete sellers_product_url(@other_product)
    end
  end

end
