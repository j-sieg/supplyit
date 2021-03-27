require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :firefox, screen_size: [1400, 1400]

  def seller_login_as(seller)
    email =
      case seller when Symbol then sellers(seller).email
      else seller.email
      end

    visit new_seller_session_path
    fill_in "Email", with: email
    fill_in "Password", with: "Metamphetam1n3!"
    click_on "Log in"
  end

  def user_login_as(user)
    user =
      case user when Symbol then users(user).email
      else user.email
      end

    visit new_user_session_path
    fill_in "Email", with: email
    fill_in "Password", with: "1supersecret!"
    click_on "Log in"
  end
end
