require 'rails_helper'

RSpec.describe Admin::RequestsController, :type => :controller do
  let(:user) { create(:user) }

  user_sign_in

  describe "GET #index" do
    let(:get_index) do
      get :index
    end

    before { get_index }

    context "when signed in", sign_in: true do
      context "when user" do
        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
      end


      context "when admin" do
        let(:user) { create(:user, admin: true) }

        it "renders index view" do
          expect(response).to render_template :index
        end
      end
    end


    context "when not signed in" do
      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST #create" do
    let(:post_create) do
      post :create, admin_request: {request_positions_attributes: [attributes_for(:admin_request_position)]}
    end

    context "when signed in", sign_in: true do
      context "when user is admin" do
        let(:user) { create(:user, admin: true) }

        it "creates a new request" do
          expect{post_create}.to change(Admin::Request, :count).by(1)
        end

        it "redirects to requests list" do
          post_create
          expect(response).to redirect_to admin_requests_path
        end
      end

      context "when user is not admin" do
        let(:user) { create(:user) }

        it "doesn't create a new request" do
          expect{post_create}.not_to change(Admin::Request, :count)
        end

        it "redirects to root_path" do
          post_create
          expect(response).to redirect_to root_path
        end
      end
    end

    context "when not signed in" do
      it "doesn't create a new request" do
        expect{post_create}.not_to change(Admin::Request, :count)
      end

      it "redirects to login page" do
        post_create
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST #merge" do
    let!(:requests) { create_list(:admin_request, 2) }

    let(:post_merge) do
      post :merge, merge_requests: [requests[0].id, requests[1].id]
    end

    context "when signed in", sign_in: true do
      context "when user" do
        it "doesn't create a new request" do
          expect{post_merge}.not_to change(Admin::Request, :count)
        end

        it "redirects to root_path" do
          post_merge
          expect(response).to redirect_to root_path
        end
      end

      context "when admin" do
        let(:user) { create(:user, admin: true) }

        it "creates a new request" do
          expect{post_merge}.to change(Admin::Request, :count).by(-1)
        end

        it "redirects to requests list" do
          post_merge
          expect(response).to redirect_to admin_requests_path
        end
      end
    end

    context "when not signed in" do
      it "doesn't create a new request" do
        expect{post_merge}.not_to change(Admin::Request, :count)
      end

      it "redirects to login page" do
        post_merge
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
