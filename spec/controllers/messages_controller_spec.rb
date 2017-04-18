require 'rails_helper'

describe MessagesController, type: :controller do
  describe 'GET #index' do
    let(:message) { FactoryGirl.create(:message) }
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
end
