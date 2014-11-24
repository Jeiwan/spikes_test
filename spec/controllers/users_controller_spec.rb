require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user) { create(:user) }

  user_sign_in

  describe "GET #cart" do
    let(:products) { create_list(:product, 5)  }
    let(:get_cart) { get :cart  }
    let(:product1_in_cart) do
      {"name" => products[0].name, "id" => products[0].id, "article" => products[0].article_id, "stack" => products[0].product_stack_id, "price" => products[0].price, "quantity" => 1}
    end

    let(:product2_in_cart) do
      {"name" => products[1].name, "id" => products[1].id, "article" => products[1].article_id, "stack" => products[1].product_stack_id, "price" => products[1].price, "quantity" => 1}
    end

    before do
      session[:cart] = []
      session[:cart] << product1_in_cart
      session[:cart] << product2_in_cart
      get_cart
    end

    context "when signed in", sign_in: true do
      it "returns all products that are in the cart" do
        expect(assigns(:products_in_cart)).to match_array [product1_in_cart, product2_in_cart]
      end

      it "renders cart view" do
        expect(response).to render_template :cart
      end
    end

    context "when not signed in" do
      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
