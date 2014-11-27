require_relative "../features_helper"

feature "Prodct Limit" do
  given(:admin) { create(:user, admin: true) }
  given(:article) { create(:article) }
  given!(:product) { create(:product, article: article) }

  background do
    sign_in admin
  end

  scenario "Admin sets limit for a product", js: true do
    visit admin_products_path

    expect(page).to have_content "Товары"
    expect(page).to have_selector ".products tbody tr", text: product.article.name
    expect(page).to have_content "Минимальный остаток"

    within(".products tbody tr:first-child") do
      fill_in "product_quantity_threshold", with: 5
      click_button "Задать"
    end

    expect(page).to have_content "задан"
    expect(page).to have_selector ".products tbody tr:first-child", text: product.quantity_threshold
  end
end
