require 'rails_helper'

describe Message do
  describe '#create' do
    it "is valid with a message" do
      message = FactoryGirl.build(:message)
      expect(message).to be_valid
    end

    it "is invalid without a message" do
      message = FactoryGirl.build(:message, message: nil)
      message.valid?
      expect(message.errors[:message]).to include("を入力してください")
    end
  end
end
