class MessagesController < ApplicationController
  before_action :set_groups_group, only: [:index, :create]

  def index
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(create_params)
    
    respond_to do |format|
      if @message.save
        format.json { render :index, status: 200, handlers: 'jbuilder' }
      else
        format.json { render :index, status: 500, handlers: 'jbuilder' }
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
