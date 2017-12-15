require 'rails_helper'

RSpec.describe Account::ProfilesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:profile) { FactoryBot.build(:profile, user_id: user.id) }
  let(:valid_attributes) { FactoryBot.attributes_for :profile }
  let(:invalid_attributes) { FactoryBot.attributes_for(:profile).merge({first_name: nil}) }
  let(:new_attributes) { FactoryBot.attributes_for(:profile).merge({first_name: "Johan"}) }
  let(:valid_session) { sign_in(user) }

  describe "GET #show" do
    describe "when user is logged in" do
      it "returns http success" do
        get :show, session: valid_session
        expect(response).to be_success
      end
    end

    describe "when user is not logged in" do
      it "returns http success" do
        get :show
        expect(response).to have_http_status(:redirect)
      end
      it " will redirect to login url" do
        get :show
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, session: valid_session
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested profile" do
        put :update, params: { id: profile.to_param, profile: new_attributes }, session: valid_session
        user.profile.reload
      end

      it "redirects to the profile" do
        put :update, params: { id: profile.to_param, profile: valid_attributes }, session: valid_session
        expect(response).to redirect_to(account_profiles_url)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: profile.to_param, profile: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end
end
