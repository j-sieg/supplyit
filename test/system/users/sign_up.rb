require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "signs up with valid credentials" do
    visit new_user_registration_path

    within "form" do
      fill_in "Phone number", with: '639175191911'
      fill_in "Email", with: "jsieg@example.com"
      fill_in "Password", with: "it's m3???"
      fill_in "Password confirmation", with: "it's m3???"

      fill_in "Full name", with: "James Siega"
      fill_in "Birthday", with: 22.years.ago.to_date.to_s
      fill_in "Address", with: "Over there"

      assert_difference 'User.count' do
        click_on "Sign up"
      end
    end

    assert_text "Welcome! You have signed up successfully"
  end

  test "invalid credentials" do
    visit new_user_registration_path

    within "form" do
      assert_no_difference 'User.count' do
        click_on "Sign up"
      end
    end

    # Only count 6 fields even though there are 7 because
    # there are no errors in the password confirmation
    # when the password is empty
    assert_selector "span.text-danger", count: 6
  end
end