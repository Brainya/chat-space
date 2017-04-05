class GroupsController < ApplicationController
  protect_from_forgery except: :create

  def new
    @users = User.all
  end

  def create
    group = Group.new
    group.name = params[:chat_group][:name]
    group.save

    redirect_to root_path
  end
end
