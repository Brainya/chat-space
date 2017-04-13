class MessagesController < ApplicationController
  def create
    message = Message.new(create_params)

    flash[:alert] = message.errors.full_messages[0] unless message.save
    redirect_to group_path(message.group.id)
  end

  private

  def create_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
