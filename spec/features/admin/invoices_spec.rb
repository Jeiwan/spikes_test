require_relative "../features_helper"

feature "Invoices" do
  given(:admin) { create(:user, admin:true) }
  given!(:invoice) { create(:admin_invoice)  }

  background do
    sign_in admin
  end

  scenario "Admin visits invoices page and sees a list of invoices" do
    visit admin_invoices_path

    expect(page).to have_content "Приходовать новую накладную"
    expect(page).to have_selector ".all-invoices tbody tr", count: 3
  end

  scenario "Admin adds a new invoice", js: true do
    visit admin_invoices_path

    expect(page).to have_selector "form#new_admin_invoice"
    click_link "Добавить позицию"

    within("#products .nested-fields:first-child") do
      fill_in "Article", with: "1"
      fill_in "Quantity", with: "100"
      fill_in "Price", with: "12.5"
    end
    click_button "Приходовать"

    expect(page.current_path).to match /\/admin\/invoices\z/
    expect(page).to have_content "Накладная приходована"
    within(".all-invoices") do
      expect(page).to have_content "1"
      expect(page).to have_content "100"
      expect(page).to have_content "12.5"
    end
  end
end
