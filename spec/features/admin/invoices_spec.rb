require_relative "../features_helper"

feature "Invoices" do
  given(:admin) { create(:user, admin:true) }
  given!(:articles) { create_list(:article, 10)  }
  given!(:invoice) { create(:admin_invoice)  }

  background do
    sign_in admin
  end

  scenario "Admin visits invoices page and sees a list of invoices", js: true do
    visit admin_invoices_path

    expect(page).to have_content "Приходовать новую накладную"
    expect(page).to have_selector ".all-invoices tbody tr", count: 3
  end

  scenario "Admin adds a new invoice", js: true do
    visit admin_invoices_path

    expect(page).to have_selector "form#new_admin_invoice"
    click_link "Добавить позицию"

    within("#products .nested-fields:first-child") do
      select articles[7].name, from: "Наименование"
      fill_in "Количество", with: "100"
      fill_in "Цена", with: "12.5"
    end
    click_button "Приходовать"

    expect(page.current_path).to match /\/admin\/invoices\z/
    expect(page).to have_content "Накладная приходована"
    within(".all-invoices") do
      expect(page).to have_content articles[7].name
      expect(page).to have_content "100"
      expect(page).to have_content "12.5"
    end

    visit root_path
    expect(page).to have_selector ".product .name", text: articles[7].name
    expect(page).to have_selector ".product .price", text: "12.5"
  end
end
