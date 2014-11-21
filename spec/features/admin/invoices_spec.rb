require_relative "../features_helper"

feature "" do
  given(:admin) { create(:user, admin:true) }

  background do
    sign_in admin
  end

  scenario "Admin visit invoices page" do
    visit admin_invoices

    expect(page).to have_content "New Invoice"
  end

end
