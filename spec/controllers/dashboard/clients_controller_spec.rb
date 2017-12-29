require 'rails_helper'

RSpec.describe Dashboard::ClientsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:client) { FactoryBot.create(:client, user_id: user.id) }
  let(:valid_attributes) { FactoryBot.attributes_for :client }
  let(:invalid_attributes) { FactoryBot.attributes_for(:client).merge({contact_person_name: nil, company_name: nil}) }
  let(:new_attributes) { FactoryBot.attributes_for(:client).merge({contact_person_name: "Johan", company_name: "Company 1"}) }
  let(:valid_session) { sign_in(user) }

  describe "GET #index" do
    describe "when user is logged in" do
      it "returns http success" do
        get :index, session: valid_session
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
      get :show, params: { id: client.id }, session: valid_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not login" do
      get :show, params: { id: client.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, session: valid_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not login" do
      get :new
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: client.id }, session: valid_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not login" do
      get :edit, params: { id: client.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the company profile" do
        expect do
          post :create, params: { client: valid_attributes }, session: valid_session
        end.to change(Client, :count).by(1)
      end

      it "redirects to the company profile index" do
        post :create, params: { client: valid_attributes }, session: valid_session
        expect(response).to redirect_to dashboard_clients_url
      end
    end

    context "with invalid attributes" do
      it "does not save the company profile" do
        expect do
          post :create, params: { client: invalid_attributes }, session: valid_session
        end.to change(Client, :count).by(0)
      end
      it "renders new on failed create" do
        post :create, params: { client: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:success)
      end
    end

    it " will redirect to login url if user is not login" do
      post :create, params: { id: client.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "saves valid company profile" do
        allow(controller).to receive(:current_user).and_return(client.user)
        expect do
          put :update, params: { id: client.id, client: { contact_person_name: "Name 1" } }, session: valid_session
        end.to change{ client.reload.contact_person_name }.to("Name 1")
      end
      it "redirects on save" do
        allow(controller).to receive(:current_user).and_return(client.user)
        put :update, params: { id: client.id, client: { contact_person_name: "Name 1" } }, session: valid_session
        expect(response).to redirect_to dashboard_clients_url
      end
    end

    context "with invalid attributes" do
      it "does not save invalid company profile" do
        allow(controller).to receive(:current_user).and_return(client.user)
        expect do
          put :update, params: { id: client.id, client: invalid_attributes }, session: valid_session
        end.to_not change(client, :contact_person_name)
      end

      it "renders edit on failed updated" do
        allow(controller).to receive(:current_user).and_return(client.user)
        put :update, params: { id: client.id, client: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end

    it " will redirect to login url if user is not login" do
      post :create, params: { id: client.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "DELETE #destroy" do
    context "success" do
      it "when deletes the company profile" do
        allow(controller).to receive(:current_user).and_return(client.user)
        expect do
          delete :destroy, params: { id: client.id }, session: valid_session
        end.to change(Client, :count).by(-1)
      end
      it "redirects to the company profile index" do
        allow(controller).to receive(:current_user).and_return(client.user)
        delete :destroy, params: { id: client.id }, session: valid_session
        expect(response).to redirect_to dashboard_clients_url
      end
    end

    it " will redirect to login url if user is not login" do
      post :create, params: { id: client.id }
      expect(response).to redirect_to new_user_session_url
    end
  end
end
