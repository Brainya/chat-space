class MessagesController < ApplicationController
  def create
    message = Message.new(create_params)

    if message.save
      redirect_to group_path(params[:group_id])
    else
      redirect_to group_path(params[:group_id]), alert: message.errors.full_messages[0]
    end
  end

  private

  def create_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
