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

    if name.empty?
      redirect_to new_group_path, alert: "グループ名が入力されていません。"
      return
    elsif groups.exists?(name: name)
      redirect_to new_group_path, alert: "既に同じ名前のグループがあります。"
      return
    elsif user_ids.length <= 0
      redirect_to new_group_path, alert: "チャットメンバーが選択されていません。"
      return
    end

    group = Group.new
    group.name = name
    group.save
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
  end
end
