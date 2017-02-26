class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post  = current_user.posts.build(post_params)
    if @post.save
      redirect_to home_index_path, notice: 'Post criado com sucesso'
    else
      @user = current_user
      @posts = Post.includes(:author).all
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render 'home/index'
    end
  end

  def destroy
    post = current_user.posts.find params[:id]
    post.destroy
    redirect_to home_index_path, notice: 'Post deletado com sucesso'
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end