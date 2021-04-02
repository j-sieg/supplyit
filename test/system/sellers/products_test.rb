require "application_system_test_case"

class Sellers::ProductsTest < ApplicationSystemTestCase
  setup do
    @seller = sellers(:heisenberg)
    seller_login_as(@seller)
  end

  test "shows all products of the seller" do
    find "h1", text: "Your products that are currently on the market"
    @seller.products.each do |product|
      product_article = "article#product_#{product.id}"
      assert_selector product_article
      within product_article do
        assert_selector "a[href='#{sellers_product_path(product)}']", text: product.name
      end
    end
  end

  test "looking at a product in detail" do
    product = @seller.products.first
    product_article = "article#product_#{product.id}"
    within product_article do
      click_link product.name
    end

    assert_selector "h5", text: product.name
    assert_selector "li.list-group-item", text: "Price: ₱#{product.price}"
    assert_selector "li.list-group-item", text: "Location: #{product.location}"
    product.categories.each do |category|
      assert_selector "button", text: category.name
    end
  end

  test "invalid product input" do
    click_link "Add a product"
    assert_selector "h1", text: "Add a new product"

    within 'form#product-form' do
      click_button "Create Product"
    end

    assert_selector "span#name-errors", text: "can't be blank"
    assert_selector "span#price-errors", text: "can't be blank"
    assert_selector "span#location-errors", text: "can't be blank"
  end

  test "adding a product" do
    click_link "Add a product"
    assert_selector "h1", text: "Add a new product"

    within 'form#product-form' do
      fill_in "Name", with: "New Product"

      select Category.first.name, from: "product_category_ids"
      select Category.last.name, from: "product_category_ids"

      fill_in "Price", with: "999"
      fill_in "Location", with: "5km away from you"

      assert_difference -> { @seller.products.count } => 1, -> { CategoryProduct.count } => 2 do
        click_button "Create Product"
      end
    end

    assert_selector 'h5.card-title', text: 'New Product'
  end

  test "updating a product" do
    product = @seller.products.first
    product_article = "article#product_#{product.id}"
    within product_article do
      click_link product.name
    end

    assert_selector "h5", text: product.name
    click_link "Edit #{product.name}"

    assert_selector "h1", text: "Editing #{product.name}"

    within "form#product-form" do
      fill_in "Name", with: "Updated Product"

      select Category.first.name, from: "product_category_ids"
      select Category.last.name, from: "product_category_ids"

      fill_in "Price", with: "698.95"
      fill_in "Location", with: "20km away from you"

      assert_no_difference '@seller.products.count' do
        click_button 'Update Product'
      end
    end

    assert_selector "h5", text: "Updated Product"
    assert_selector "li.list-group-item", text: "Price: ₱698.95"
    assert_selector "li.list-group-item", text: "Location: 20km away from you"
    assert_selector "button", text: Category.first.name
    assert_selector "button", text: Category.last.name
  end

  test "deleting a product" do
    product = products(:destroyable_product_from_walt)

    product_article = "article#product_#{product.id}"
    assert_selector product_article

    within product_article do
      click_link product.name
    end

    accept_alert { click_button "Delete this product" }

    assert_no_selector product_article
  end

end