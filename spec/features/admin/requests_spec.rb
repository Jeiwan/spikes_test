require_relative "../features_helper"

feature "Requests" do
  given(:admin) { create(:user, admin: true) }
  given!(:articles) { create_list(:article, 2) }
  given!(:product_request) { create(:admin_request)  }

  before do
    sign_in admin
  end

  scenario "Admin visits requests page" do
    visit admin_requests_path

    expect(page).to have_selector "h1", text: "Заявки на поставку"
    expect(page).to have_content "Создать заявку"
  end

  scenario "Admin creates a new request", js: true do
    visit admin_requests_path

    expect(page).to have_selector "form#new_admin_request"
    click_link "Добавить позицию"

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

    expect(page.current_path).to match /\A\/admin\/invoices/
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
    expect(page).to have_selector ".all-requests tbody tr:first-child td:first-child", text: "Выполнена"
  end
end
