require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product with line items cannot be destroyed" do
    product = products(:aggregate)
    new_item = LineItem.create(product_id: product.id)
    carts(:empty_cart).add_item(new_item)
    new_item.save!

    assert_no_difference('Product.count') do
      product.destroy
    end

    assert_raise ActiveRecord::RecordNotDestroyed do
      product.destroy!
    end
  end
end
