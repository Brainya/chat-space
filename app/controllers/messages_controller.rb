class MessagesController < ApplicationController
  def create
    Message.create(create_params)
    redirect_to controller: :groups, action: :show, id: params[:group_id]
  end

  private

  def create_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
