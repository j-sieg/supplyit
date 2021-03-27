require "application_system_test_case"

class Sellers::SessionsTest < ApplicationSystemTestCase

  test "invalid session renders flash message" do
    visit(new_seller_session_path).then { click_button "Log in" }
    assert_text "Invalid Email or password"
  end

  test "automatically logs in and redirects to products after sign up" do
    visit new_seller_registration_path

    within "form" do
      fill_in "Email", with: 'somebodynew@example.com'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_on "Sign up"
    end

    find 'h1', text: 'Your products that are currently on the market'
    find 'h3', text: 'You have none'
  end

end