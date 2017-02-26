class UsersController < ApplicationController
  before_action :set_user, except: :index

  has_scope :search_by_name_or_username

  def index
    @users = apply_scopes(User).page params[:page]
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