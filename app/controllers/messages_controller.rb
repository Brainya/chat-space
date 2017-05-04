class MessagesController < ApplicationController
  before_action :set_groups_group, only: [:index, :create, :set_update_time]

  @@update_time = Time.new

  def index
    @message = Message.new
    @messages = @group.messages.where('created_at > ?', @@update_time)
    
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = current_user.messages.new(create_params)
    
    respond_to do |format|
      if @message.save
        format.json
      else
        format.json
      end
    end
  end

  def set_update_time
    @@update_time = @group.messages.order(created_at: :desc).pluck(:created_at).first
  end

  private

  def set_groups_group
    @groups = Group.includes(:users, :messages)
    @group = @groups.find(params[:group_id])
  end

  def create_params
    params.require(:message).permit(:message, :user_id, :image).merge(group_id: params[:group_id])
  end
end
