class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @posts = Feed.new(@user).posts
    @post = @user.posts.build
  end
end