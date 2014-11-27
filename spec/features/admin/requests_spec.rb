require_relative "../features_helper"

feature "Requests" do
  given(:user) { create(:user) }
  given(:admin) { create(:user, admin: true) }
  given!(:articles) { create_list(:article, 2) }
  given!(:product_request) { create(:admin_request, status: 1)  }
  given!(:product) { create(:product, article: articles[0]) }

  before do
    sign_in admin
  end

  scenario "Admin visits requests page" do
    visit admin_requests_path

    expect(page).to have_selector "h1", text: "Заявки на поставку"
    expect(page).to have_content "Создать заявку"
  end

  scenario "Admin creates a new request", js: true do
    visit new_admin_request_path

    expect(page).to have_selector "form#new_admin_request"

    within("#products .nested-fields:first-child") do
      select articles[1].name, from: "Наименование"
      fill_in "Количество", with: "100"
    end
    click_button "Создать"

    expect(page.current_path).to match /\/admin\/requests\z/
    expect(page).to have_content "Заявка создана"
    within(".all-requests") do
      expect(page).to have_content articles[1].name
      expect(page).to have_content "100"
    end
  end

  scenario "Admin creates a new request without filling necessary fields", js: true do
    visit new_admin_request_path

    click_button "Создать"

    expect(page).to have_content "Ошибка"
  end

  scenario "Admin sets default quantity threshold for all products", js: true do
    visit admin_requests_path
    
    expect(page).to have_content "Минимальное количество"
    expect(page).to have_selector "form#quantity_threshold"
    expect(find_field("threshold").value).to eq "10"

    within("form#quantity_threshold") do
      fill_in :threshold, with: "20"
      click_button "Установить"
      sleep 0.1
      expect(page).to have_selector "span.ok", text: "Установлено"
    end
  end

  scenario "Admin executes a request", js: true do
    visit admin_requests_path

    expect(page).to have_selector ".all-requests tr", text: product_request.request_positions[0].article.name
    expect(page).to have_selector ".all-requests tr", text: product_request.request_positions[1].article.name

    within(".all-requests") do
      click_link "Приходовать"
    end

    expect(page.current_path).to match /\A\/admin\/requests\/\d+\/invoices\/new\z/
    expect(page).to have_selector "#products > .nested-fields", count: 2

    within("#products > .nested-fields:first-child") do
      expect(find_field("Наименование").value).to eq "1"
      fill_in "Цена", with: 10
    end

    within("#products > .nested-fields:nth-child(2)") do
      expect(find_field("Наименование").value).to eq "2"
      fill_in "Цена", with: 15
    end
    click_button "Приходовать"
    expect(page).to have_content "Накладная приходована"

    visit admin_requests_path
    expect(page).to have_selector ".all-requests tbody tr.executed", count: 1
    expect(page).to have_selector ".all-requests tbody tr.executed", text: "Выполнена"
  end

  scenario "A new request is created after user's bought a limited product", js: true do
    visit root_path
    click_link "Log out"

    sign_in user
    visit root_path
    expect(page).to have_selector ".product", count: 1
    within(".product") do
      expect(page).to have_link "В корзину"
      click_link "В корзину"
      expect(page).to have_content "В корзине"
    end
    click_link "Корзина"
    click_link "Оформить"

    visit root_path
    click_link "Log out"

    sign_in admin
    visit admin_requests_path
    within(".all-requests") do
      expect(page).to have_content product.article.name
      expect(page).to have_content "Новая"
      expect(page).to have_link "Редактировать"
      expect(page).to have_link "Подтвердить"
    end
  end

  given!(:fresh_requests) { create_list(:admin_request, 2) }
  scenario "Admin merges new requests", js: true do
    visit admin_requests_path

    expect(page).to have_selector "tr.fresh", count: 2

    check "merge_request_#{fresh_requests[0].id}"
    check "merge_request_#{fresh_requests[1].id}"
    click_button "Объединить заявки"

    expect(page).to have_content "объединены"
    expect(page).to have_selector "tr.fresh", count: 1
  end

  scenario "Admin edits new created request", js: true do
    visit admin_requests_path

    within('.all-requests') do
      first(:link, text: 'Редактировать').click
    end
    expect(page.current_path).to match /\A\/admin\/requests\/\d+\/edit\z/
    expect(page).to have_content 'Редактировать заявку'
    within("form .nested-fields:first-child") do
      fill_in 'Количество', with: 575
    end
    click_button 'Редактировать'
    expect(page.current_path).to match /\A\/admin\/requests\z/
    expect(page).to have_content 'отредактирована'
    expect(page).to have_content '575'
  end

  scenario "Admin confirm new created request" do
    visit admin_requests_path

    within(".all-requests") do
      first(:link, text: 'Подтвердить').click
    end
    expect(page.current_path).to match /\A\/admin\/requests\z/
    expect(page).to have_content 'подтверждена'
  end
end
