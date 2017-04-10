class GroupsController < ApplicationController
  def new
    @group = Group.new
    @users = User.all
  end

  def show
    @groups = Group.all
    @group = @groups.find(params[:id])
    user_ids = UserGroup.where(group_id: params[:id]).pluck(:user_id)
    @users = User.find(user_ids)
    @members_string = "Members: #{@users.pluck(:name).join(", ")}"
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.all
  end

  def update
    group = Group.find(params[:id])
    group.name = create_params[:name]

    unless group.save || user_ids_check_boxes_validation
      redirect_to edit_group_path, id: group.id, alert: group.errors.full_messages[0]
      return
    end

    user_ids = create_params[:user_ids].drop(1)

    unless user_ids_check_boxes_validation(group, user_ids)
      redirect_to edit_group_path, id: group.id, alert: group.errors.full_messages[0]
      return
    end

    user_ids.each do |id|
      user = User.find(id)
      UserGroup.where(user_id: user.id, group_id: group.id).first_or_create
    end

    UserGroup.where(group_id: group.id).where.not(user_id: user_ids).destroy_all
    redirect_to action: :show, id: group.id
  end

  def create
    group = Group.new(name: create_params[:name])
    user_ids = create_params[:user_ids].drop(1)

    unless user_ids_check_boxes_validation(group, user_ids)
      redirect_to new_group_path, alert: group.errors.full_messages[0]
      return
    end
    unless group.save
      redirect_to new_group_path, alert: group.errors.full_messages[0]
      return
    end

    user_ids.each do |id|
      user = User.find(id)
      UserGroup.create(user_id: user.id, group_id: group.id)
    end

    redirect_to action: :show, id: group.id
  end

  private
  def create_params
    params.require(:group).permit(:name, :user_ids => [])
    params.require(:group).permit(:name, user_ids: [])
  end

  def user_ids_check_boxes_validation(group, user_ids)
    unless user_ids.length > 0
      group.errors.add("メンバー", "を選択してください")
      return false
    end

    return true
  end
end
