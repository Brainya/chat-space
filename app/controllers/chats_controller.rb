class ChatsController < ApplicationController
  before_action :move_to_index

  def index
  end

  private
  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end
end
