class MessagesController < ApplicationController
  before_action :set_groups_group, only: [:index, :create]

  def index
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(create_params)

    respond_to do |format|
      if @message.save
        flash[:notice] = 'メッセージが送信されました'
        format.html { redirect_to group_messages_path(@message.group.id) }
        format.json { render json: @message }
      else
        flash.now[:alert] = @message.errors.full_messages[0]
        format.html { render :index }
      end
    end
  end

  private

  def set_groups_group
    @groups = Group.includes(:users, :messages)
    @group = @groups.find(params[:group_id])
  end

  def create_params
    params.require(:message).permit(:message, :user_id).merge(group_id: params[:group_id])
  end
end
