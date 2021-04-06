require "application_system_test_case"

class StoreTest < ApplicationSystemTestCase
  test "searching for item by name and category" do
    visit store_url
    product = products(:aggregate)
    category = product.categories.first

    within "#search-form" do
      fill_in "name", with: product.name
      select category.name.capitalize, from: :category

      click_on "Search"
    end

    Product.available.where.not(name: product.name).each do |prod|
      assert_no_selector "article##{dom_id(prod)}"
    end

    assert_text "Search results for \"#{product.name}\" in the \"#{category.name}\" category"
    assert_selector "article##{dom_id(product)}"
  end

  test "searching for something that does not exist" do
    visit store_url
    product_name = "Something that doesn't exist"

    within "#search-form" do
      fill_in "name", with: product_name

      click_on "Search"
    end

    assert_text "Search results for \"#{product_name}\""
    assert_text "There are no products"
  end
end