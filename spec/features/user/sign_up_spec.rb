require_relative "../features_helper"

feature "Signing Up" do
  given(:user) { build(:user)  }

  scenario "User signs up" do
    visit root_path

    expect(page).to have_link "Sign up"
    click_link "Sign up"

    expect(page.current_path).to match /\/users\/sign_up\z/

    fill_in "Username", with: user.username
    fill_in "user_password", with: user.password
    fill_in "Password confirmation", with: user.password_confirmation
    click_button "Sign up"

    expect(page).to have_content "successfully"
  end

end
