require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  let(:user) { create(:user) }

  user_sign_in

  describe "GET #index" do
    let(:products) { create_list(:product, 2) }

    let(:get_index) { get :index  }

    before { get_index  }

    it "returns all products" do
      expect(assigns(:products)).to match_array products
    end

    it "renders index view" do
      expect(response).to render_template :index
    end
  end

  describe "POST #add_to_cart" do
    let(:product) { create(:product) }
    let(:post_add_to_cart) do
      post :add_to_cart, product_id: product.id, format: :js
    end

    before { post_add_to_cart }

    context "when signed in", sign_in: true do
      it "finds a product" do
        expect(assigns(:product)).to eq product
      end

      it "adds the product to the cart" do
        expect(session[:cart][0]).to eq({name: product.name, id: product.id, article: product.article_id, stack: product.product_stack_id, price: product.price, quantity: 1})
      end
    end

    context "when not signed in" do
      it "returns 401 status code" do
        expect(response.status).to eq 401
      end
    end
  end
end
