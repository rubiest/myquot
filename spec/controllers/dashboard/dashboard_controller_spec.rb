require 'rails_helper'

RSpec.describe Dashboard::DashboardController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_session) { sign_in(user) }

  describe "GET #index" do
    describe "when user is logged in" do
      before { valid_session }

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "when user is not logged in" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
      it " will redirect to login url" do
        get :index
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
