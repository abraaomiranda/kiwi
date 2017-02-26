class FollowCreator
  def initialize(follow)
    @follow = follow
  end

  def create
    create_follow && notify
  end

  private
  attr_reader :follow

  def create_follow
    follow.save
  end

  def notify
    notification = Notification.new(owner: follow.follower,
                                    recipient: follow.followed,
                                    message:'começou a seguir você.',
                                    reference_id: follow.follower_id,
                                    reference_class: 'User')
    NotificationCreator.new(notification).create
  end
end