class Feed
  attr_reader :posts

  def initialize(user, params={})
    @user = user
    set_posts(params[:page])
  end

  def set_posts(page)
    follows_ids = @user.follows.pluck(:id) << @user.id
    @posts = Post.where(user_id: follows_ids).includes(:author).page(page)
  end
end