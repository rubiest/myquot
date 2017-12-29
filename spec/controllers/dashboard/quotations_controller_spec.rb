require 'rails_helper'

RSpec.describe Dashboard::QuotationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:client) { FactoryBot.create(:client, user_id: user.id) }
  let(:quotation) { FactoryBot.create(:quotation, user_id: user.id, client_id: client.id) }
  let(:valid_attributes) { FactoryBot.attributes_for :quotation, client_id: client.id }
  let(:invalid_attributes) { FactoryBot.attributes_for(:quotation).merge({client_id: nil}) }
  let(:new_attributes) { FactoryBot.attributes_for(:quotation).merge({note: "Note is here"}) }
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
      get :show, params: { id: quotation.id }, session: valid_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not login" do
      get :show, params: { id: quotation.id }
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
      get :edit, params: { id: quotation.id }, session: valid_session
      expect(response).to have_http_status(:success)
    end
    it " will redirect to login url if user is not login" do
      get :edit, params: { id: quotation.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the quotation" do
        expect do
          post :create, params: { quotation: valid_attributes }, session: valid_session
        end.to change(Quotation, :count).by(1)
      end

      it "redirects to the quotation index" do
        post :create, params: { quotation: valid_attributes }, session: valid_session
        expect(response).to redirect_to dashboard_quotations_url
      end
    end

    context "with invalid attributes" do
      it "does not save the quotation" do
        expect do
          post :create, params: { quotation: invalid_attributes }, session: valid_session
        end.to change(Quotation, :count).by(0)
      end
      it "renders new on failed create" do
        post :create, params: { quotation: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:success)
      end
    end

    it " will redirect to login url if user is not login" do
      post :create, params: { id: quotation.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "saves valid quotation" do
        allow(controller).to receive(:current_user).and_return(quotation.user)
        expect do
          put :update, params: { id: quotation.id, quotation: { note: "Note 1" } }, session: valid_session
        end.to change{ quotation.reload.note }.to("Note 1")
      end
      it "redirects on save" do
        allow(controller).to receive(:current_user).and_return(quotation.user)
        put :update, params: { id: quotation.id, quotation: { note: "Name 1" } }, session: valid_session
        expect(response).to redirect_to dashboard_quotations_url
      end
    end

    context "with invalid attributes" do
      it "does not save invalid quotation" do
        allow(controller).to receive(:current_user).and_return(quotation.user)
        expect do
          put :update, params: { id: quotation.id, quotation: invalid_attributes }, session: valid_session
        end.to_not change(quotation, :note)
      end

      it "renders edit on failed updated" do
        allow(controller).to receive(:current_user).and_return(quotation.user)
        put :update, params: { id: quotation.id, quotation: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end

    it " will redirect to login url if user is not login" do
      post :create, params: { id: quotation.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

  describe "DELETE #destroy" do
    context "success" do
      it "when deletes the quotation" do
        allow(controller).to receive(:current_user).and_return(quotation.user)
        expect do
          delete :destroy, params: { id: quotation.id }, session: valid_session
        end.to change(Quotation, :count).by(-1)
      end
      it "redirects to the company profile index" do
        allow(controller).to receive(:current_user).and_return(quotation.user)
        delete :destroy, params: { id: quotation.id }, session: valid_session
        expect(response).to redirect_to dashboard_quotations_url
      end
    end

    it " will redirect to login url if user is not login" do
      post :create, params: { id: quotation.id }
      expect(response).to redirect_to new_user_session_url
    end
  end

end
