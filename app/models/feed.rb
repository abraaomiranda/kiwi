class Feed

  def initialize(user)
    @user = user
  end

  def posts
    follows_ids = @user.follows.pluck(:id) << @user.id
    Post.where(user_id: follows_ids).includes(:author)
  end
end