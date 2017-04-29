class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]
  before_action :set_users, only: [:new, :create, :edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:notice] = 'グループが作成されました'
      redirect_to group_messages_path(@group.id)
    else
      flash.now[:alert] = @group.errors.full_messages[0]
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = 'グループ情報が更新されました'
      redirect_to group_messages_path(@group.id)
    else
      flash.now[:alert] = @group.errors.full_messages[0]
      render :edit
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def group_params
    user_ids = User.where(name: params[:usernames].split(',')).pluck(:id)
    params.require(:group).permit(:name).merge(user_ids: user_ids)
  end
end
