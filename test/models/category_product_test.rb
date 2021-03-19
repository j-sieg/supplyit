require "test_helper"

class CategoryProductTest < ActiveSupport::TestCase
  setup do
    @category = categories(:aggregates)
  end

  test "category and product reference must be unique" do
    assert_raise ActiveRecord::RecordNotUnique do
      @category.products << products(:aggregate)
    end
  end
end
