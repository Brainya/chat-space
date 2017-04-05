class GroupsController < ApplicationController
  protect_from_forgery except: :create

  def new
    @users = User.all
  end
end
