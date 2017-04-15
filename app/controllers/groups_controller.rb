class GroupsController < ApplicationController
  before_action :set_group, except: [:new, :create]
  before_action :set_users

  def new
    @group = Group.new
  end

  def create
    group = Group.new(create_params)

    if group.save
      redirect_to group_messages_path(group.id)
    else
      render :new, inline: group.errors.full_messages[0]
    end
  end

  def edit
  end

  def update
    if @group.update(create_params)
      redirect_to group_messages_path(@group.id)
    else
      render :edit, inline: @group.errors.full_messages[0]
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def create_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
