class UsersController < ApplicationController

  before_action :set_user, except: :index

  def index
    @users = User.all.page params[:page]
  end

  def show
    @posts = @user.posts.includes(:author).page params[:page]
  end

  def follows
    @users = @user.follows.page params[:page]
  end

  def followers
    @users = @user.followers.page params[:page]
  end

  private

  def set_user
    @user = User.find params[:id]
  end

end