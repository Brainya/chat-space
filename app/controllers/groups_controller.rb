class GroupsController < ApplicationController
  protect_from_forgery except: :create

  def new
    @users = User.all
  end

  def create
    groups = Group.all
    name = create_params[:name].strip
    user_ids = create_params[:user_ids].drop 1 # remove a empty element

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

    user_ids.each do |id|
      user = User.find id
      user.group_id = group.id
      user.save
    end

    redirect_to root_path
  end

  private
  def create_params
    params[:chat_group].permit :name, :user_ids => []
  end
end
