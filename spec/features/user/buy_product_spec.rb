require_relative "../features_helper"

feature "Buying Products" do
  given(:user) { create(:user)  }
  given(:articles) { create_list(:article, 2)  }
  given!(:product1) { create(:product, article: articles[0]) }
  given!(:product2) { create(:product, article: articles[1]) }

  before do
    sign_in user
  end

  scenario "User adds a product to the cart", js: true do
    visit root_path
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name

    within(".product:first-child") do
      expect(page).to have_link "В корзину"
      click_link "В корзину"
      expect(page).to have_content "В корзине"
    end

    expect(page).to have_content "добавлен в корзину"
  end

  scenario "User views his cart", js: true do
    visit root_path

    within(".product:first-child") do
      click_link "В корзину"
    end

    sleep 0.1
    click_link "Корзина"
    expect(page.current_path).to match /\A\/cart\z/
    expect(page).to have_content "Корзина"
    expect(page).to have_content product1.name
  end

  scenario "User makes an order", js: true do
    visit root_path

    within(".product:first-child") do
      click_link "В корзину"
    end

    sleep 0.1
    click_link "Корзина"
    expect(page).to have_link "Оформить"
    click_link "Оформить"
    expect(page).to have_content "Заказ оформлен"
  end

  scenario "User remove a product from the cart", js: true do
    visit root_path

    within(".product:first-child") do
      click_link "В корзину"
    end
    sleep 0.1

    click_link "Корзина"
    within("#product_#{product1.id}") do
      expect(page).to have_link "Убрать"
      click_link "Убрать"
    end

    expect(page).not_to have_content product1.name
    expect(page).to have_content "убран из корзины"
    expect(page).to have_content "Корзина пуста"
  end

end
