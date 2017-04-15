class MessagesController < ApplicationController
  before_action :set_groups_group, only: [:index, :create]

  def index
    @message = Message.new
  end

  def create
    @message = Message.new(create_params)

    if @message.save
      flash[:notice] = 'メッセージが送信されました'
      redirect_to group_messages_path(@message.group.id)
    else
      flash.now[:alert] = @message.errors.full_messages[0]
      render :index
    end
  end

  private

  def set_groups_group
    @groups = Group.includes(:users, :messages)
    @group = @groups.find(params[:group_id])
  end

  def create_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
