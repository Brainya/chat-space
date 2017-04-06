class GroupsController < ApplicationController
  protect_from_forgery except: :create

  def new
    @users = User.all
  end

  def create
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
