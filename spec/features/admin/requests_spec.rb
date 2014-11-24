require_relative "../features_helper"

feature "Requests" do
  given(:admin) { create(:user, admin: true) }
  given!(:articles) { create_list(:article, 2) }
  given!(:request) { create(:admin_request)  }

  before do
    sign_in admin
  end

  scenario "Admin visits requests page" do
    visit admin_requests_path

    expect(page).to have_selector "h1", text: "Заявки на поставку"
    expect(page).to have_content "Создать заявку"
  end

  scenario "Admin create a new request", js: true do
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

end
