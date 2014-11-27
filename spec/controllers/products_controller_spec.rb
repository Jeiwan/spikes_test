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

  describe "GET #index_admin" do
    let(:products) { create_list(:product, 2) }

    let(:get_index_admin) { get :index_admin  }

    before { get_index_admin  }

    context "when signed in as admin", sign_in: true do
      let(:user) { create(:user, admin: true) }

      it "returns all products" do
        expect(assigns(:products)).to match_array products
      end

      it "renders index view" do
        expect(response).to render_template 'admin/products/index'
      end
    end

    context "when signed in as user", sign_in: true do
      it "redirects to root_path" do
        expect(response).to redirect_to root_path
      end
    end

    context "when not signed in" do
      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
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
        expect(session[:cart][0]).to eq({name: product.name, id: product.id, article: product.article_id, price: product.price, quantity: 1})
      end
    end

    context "when not signed in" do
      it "returns 401 status code" do
        expect(response.status).to eq 401
      end
    end
  end

  describe "POST #remove_from_cart" do
    let(:product) { create(:product) }
    let(:post_remove_from_cart) do
      post :remove_from_cart, product_id: product.id, format: :js
    end

    before do
      session[:cart] = []
      session[:cart] << {name: product.name, id: product.id, article: product.article_id, price: product.price, quantity: 1}
      post_remove_from_cart
    end

    context "when signed in", sign_in: true do
      it "removes the product from the cart" do
        expect(session[:cart]).to be_empty
      end
    end

    context "when not signed in" do
      it "returns 401 status code" do
        expect(response.status).to eq 401
      end
    end
  end

  describe "PATCH #set_quantity_threshold" do
    let(:product) { create(:product) }
    let(:patch_set_quantity_threshold) do
      patch :set_quantity_threshold, id: product.id, product: {quantity_threshold: 50}, format: :js
    end

    context "when signed in", sign_in: true do
      context "when admin" do
        let(:user) { create(:user, admin: true) }
        it "updates product stack" do
          patch_set_quantity_threshold
          expect(product.reload.quantity_threshold).to eq 50
        end

        it "renders set_quantity_threshold" do
          patch_set_quantity_threshold
          expect(response).to render_template "admin/products/set_quantity_threshold"
        end
      end

      context "when user" do
        it "returns 401 status code" do
          patch_set_quantity_threshold
          expect(response.status).to eq 401
        end
      end
    end
    context "when not signed in" do
      it "returns 401 status code" do
        patch_set_quantity_threshold
        expect(response.status).to eq 401
      end
    end
  end
end
