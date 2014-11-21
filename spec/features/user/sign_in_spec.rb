require_relative "../features_helper"

feature "Signing In" do
  given(:user) { create(:user)  }

  scenario "User signs in" do
    visit root_path

    expect(page).to have_link "Log in"
    click_link "Log in"

    expect(page.current_path).to match /\/users\/sign_in\z/

    fill_in "Username", with: user.username
    fill_in "user_password", with: user.password
    click_button "Log in"

    expect(page).to have_content "successfully"
  end

end
