require 'rails_helper'

RSpec.describe Account::CompanyProfilesController, type: :controller do
  let(:enterprise_user) { FactoryBot.create(:user, enterprise: true) }
  let(:company_profile) { FactoryBot.create(:company_profile, user_id: enterprise_user.id) }
  let(:valid_attributes) { FactoryBot.attributes_for :company_profile }
  let(:invalid_attributes) { FactoryBot.attributes_for(:company_profile).merge({company_name: nil}) }
  let(:new_attributes) { FactoryBot.attributes_for(:company_profile).merge({company_name: "Johan"}) }
  let(:valid_session) { sign_in(user) }
  let(:valid_enterprise_session) { sign_in(enterprise_user) }

  describe "GET #index" do
    describe "when user is logged in" do
      it "returns http success" do
        get :index, session: valid_enterprise_session
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

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: company_profile.id }, session: valid_enterprise_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not enterprise account" do
      get :show, params: { id: company_profile.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, session: valid_enterprise_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not enterprise account" do
      get :new
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: company_profile.id }, session: valid_enterprise_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not enterprise account" do
      get :edit, params: { id: company_profile.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "POST #create" do
      context "with valid attributes" do
        it "saves the company profile" do
          expect do
            post :create, params: { company_profile: valid_attributes }, session: valid_enterprise_session
          end.to change(CompanyProfile, :count).by(1)
        end

        it "redirects to the company profile index" do
          post :create, params: { company_profile: valid_attributes }, session: valid_enterprise_session
          expect(response).to redirect_to account_company_profiles_url
        end
      end

      context "with invalid attributes" do
        it "does not save the company profile" do
          expect do
            post :create, params: { company_profile: invalid_attributes }, session: valid_enterprise_session
          end.to change(CompanyProfile, :count).by(0)
        end
        it "renders new on failed create" do
          post :create, params: { company_profile: invalid_attributes }, session: valid_enterprise_session
          expect(response).to have_http_status(:success)
        end
      end

      it " will redirect to login url if user is not enterprise account" do
        post :create, params: { id: company_profile.id }
        expect(response).to redirect_to new_user_session_url
      end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "saves valid company profile" do
        allow(controller).to receive(:current_user).and_return(company_profile.user)
        expect do
          put :update, params: { id: company_profile.id, company_profile: { company_name: "Company 1" } }, session: valid_enterprise_session
        end.to change{ company_profile.reload.company_name }.to("Company 1")
      end
      it "redirects on save" do
        allow(controller).to receive(:current_user).and_return(company_profile.user)
        put :update, params: { id: company_profile.id, company_profile: { company_name: "Company 1" } }, session: valid_enterprise_session
        expect(response).to redirect_to account_company_profiles_url
      end
    end

    context "with invalid attributes" do
      it "does not save invalid company profile" do
        allow(controller).to receive(:current_user).and_return(company_profile.user)
        expect do
          put :update, params: { id: company_profile.id, company_profile: invalid_attributes }, session: valid_enterprise_session
        end.to_not change(company_profile, :company_name)
      end

      it "renders edit on failed updated" do
        allow(controller).to receive(:current_user).and_return(company_profile.user)
        put :update, params: { id: company_profile.id, company_profile: invalid_attributes }, session: valid_enterprise_session
        expect(response).to be_success
      end
    end

    it " will redirect to login url if user is not enterprise account" do
      post :create, params: { id: company_profile.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "DELETE #destroy" do
    context "success" do
      it "when deletes the company profile" do
        allow(controller).to receive(:current_user).and_return(company_profile.user)
        expect do
          delete :destroy, params: { id: company_profile.id }, session: valid_enterprise_session
        end.to change(CompanyProfile, :count).by(-1)
      end
      it "redirects to the company profile index" do
        allow(controller).to receive(:current_user).and_return(company_profile.user)
        delete :destroy, params: { id: company_profile.id }, session: valid_enterprise_session
        expect(response).to redirect_to account_company_profiles_url
      end
    end

    it " will redirect to login url if user is not enterprise account" do
      post :create, params: { id: company_profile.id }
      expect(response).to redirect_to new_user_session_url
    end
  end
end
