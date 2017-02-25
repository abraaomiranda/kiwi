class UsersController < ApplicationController

  before_action :set_user, except: :index

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.includes(:author)
  end

  def follows
    @users = @user.follows
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find params[:id]
  end

end