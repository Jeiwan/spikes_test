require 'rails_helper'

RSpec.describe Admin::DashboardController, :type => :controller do
  describe "GET #show" do
    let(:user) { create(:user, admin: true) }
    let(:get_show) do
      get :show
    end

    user_sign_in

    before do
      get_show
    end

    context "when signed as admin", sign_in: true do
      it "returns http success" do
        expect(response).to be_success
      end

      it "renders show view" do
        expect(response).to render_template :show
      end
    end
  end
end
