class GroupsController < ApplicationController
  protect_from_forgery except: :create

  def new
    @users = User.all
  end

  def create
    group = Group.new
    group.name = params[:chat_group][:name]
    group.save

    params[:chat_group][:user_ids].each do |id|
      next if id.empty?
      
      user = User.find(id)
      user.group_id = group.id
      user.save
    end

    redirect_to root_path
  end
end
