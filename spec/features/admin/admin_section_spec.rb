require_relative "../features_helper"

feature "Admin Section" do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  scenario "Admin visits admin section" do
    sign_in admin
    visit root_path

    expect(page).to have_link "Админ-панель"
    expect(page).to have_link "Накладные"
    expect(page).to have_link "Заявки"
    expect(page).to have_link "Товары"
    expect(page).to have_link "Заказы"

    click_link "Админ-панель"
    expect(page.current_path).to match /\A\/admin\/dashboard\z/

    visit root_path
    click_link "Накладные"
    expect(page.current_path).to match /\A\/admin\/invoices\z/

    visit root_path
    click_link "Заявки"
    expect(page.current_path).to match /\A\/admin\/requests\z/

    visit root_path
    click_link "Товары"
    expect(page.current_path).to match /\A\/admin\/products\z/

    visit root_path
    click_link "Заказы"
    expect(page.current_path).to match /\A\/admin\/orders\z/
  end

  scenario "User can't visit admin section" do
    sign_in user
    visit root_path

    expect(page).not_to have_link "Админ-панель"
    expect(page).not_to have_link "Накладные"
    expect(page).not_to have_link "Заявки"
    expect(page).not_to have_link "Товары"
    expect(page).not_to have_link "Заказы"
  end
end
