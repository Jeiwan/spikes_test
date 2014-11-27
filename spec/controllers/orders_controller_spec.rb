require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { create(:user) }

  user_sign_in

  describe "GET #index_admin" do
    let!(:orders) { create_list(:order, 2) }
    let(:user) { create(:user, admin: true) }

    user_sign_in

    before do
      get :index_admin
    end

    context "when signed in as admin", sign_in: true do
      it "assigns orders" do
        expect(assigns(:orders)).to match_array orders
      end

      it "renders admin/orders/index" do
        expect(response).to render_template 'admin/orders/index'
      end
    end
  end

  describe "POST #create" do
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }

    let(:post_create) do
      post :create
    end

    context "when signed in", sign_in: true do
      context "when cart is not empty" do
        before do
          session[:cart] = []
          session[:cart] << {"name" => product1.name, "id" => product1.id, "article" => product1.article_id, "price" => product1.price, "quantity" => 1}
          session[:cart] << {"name" => product2.name, "id" => product2.id, "article" => product2.article_id, "price" => product2.price, "quantity" => 1}
        end

        it "creates a new order" do
          expect{post_create}.to change(Order, :count).by(1)
        end

        it "create a new order positions" do
          expect{post_create}.to change(OrderPosition, :count).by(2)
        end

        it "decrements product quantity" do
          post_create
          expect(product1.reload.quantity).to eq 10
          expect(product2.reload.quantity).to eq 10
        end

        it "redirects to root_path" do
          post_create
          expect(response).to redirect_to root_path
        end
      end

      context "when cart is empty" do
        it "doesn't create a new order" do
          expect{post_create}.not_to change(Order, :count)
        end

        it "redirects to root_path" do
          post_create
          expect(response).to redirect_to root_path
        end
      end
    end

    context "when not signed in" do
      it "doesn't create a new order" do
        expect{post_create}.not_to change(Order, :count)
      end

      it "redirects to login page" do
        post_create
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
