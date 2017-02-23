class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @posts = Post.all
    @post = @user.posts.build
  end
end