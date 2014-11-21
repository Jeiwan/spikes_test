require_relative "../features_helper"

feature "" do
  given(:admin) { create(:user, admin:true) }

  background do
    sign_in admin
  end

  scenario "Admin visit invoices page" do
    visit admin_invoices_path

    expect(page).to have_content "Приходовать новую накладную"
  end
end
