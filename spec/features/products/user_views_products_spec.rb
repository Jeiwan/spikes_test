require_relative "../features_helper"

feature "Products List" do
  given!(:products) { create_list(:product, 2)  }

  scenario "User can views a list of products" do
    visit root_path

    expect(page).to have_selector ".product", count: 2
  end

end
