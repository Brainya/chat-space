require 'rails_helper'

describe MessagesController, type: :controller do
  describe 'GET #index' do
    let(:message) { create(:message) }
    let(:params) { { group_id: message.group.id } }

    before do
      sign_in message.user
    end

    it "assigns a new message to @message" do
      get :index, params
      expect(assigns(:message)).to be_a_new(Message)
    end

    it "renders the :index template" do
      get :index, params
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    let(:message) { create(:message) }
    let(:params) {
      {
        message: {
          message: message.message,
          user_id: message.user.id
        },
        group_id: message.group.id
      }
    }

    before do
      sign_in message.user
    end

    it "assigns a new message to @message is valid with a message, user_id, group_id" do
      post :create, params
      expect(assigns(:message)).to be_valid
    end

    it "redirects to the group_messages_path" do
      post :create, params
      expect(response).to redirect_to group_messages_path(message.group.id)
    end

    it "renders the :index template" do
      message.message = nil
      post :create, params
      expect(response).to render_template :index
    end

    it "flash[:notice] includes messages" do
      post :create, params
      expect(flash[:notice]).not_to be_empty
    end

    it "flash.now[:alert] includes messages" do
      message.message = nil
      post :create, params
      expect(flash.now[:alert]).not_to be_empty
    end
  end
end
