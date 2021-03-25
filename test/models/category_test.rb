require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "downcases the category on save" do
    category = Category.create!(name: "UPCASE")
    assert_equal category.name, 'upcase'

    category.update(name: "CANNOT BE UPCASE")
    assert_equal category.name, 'cannot be upcase'
  end
end
