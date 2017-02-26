class NotificationCreator
  def initialize(notification)
    @notification = notification
  end

  def create
    create_notification && create_notification_job
  end

  private
  attr_reader :notification

  def create_notification
    notification.save
  end

  def create_notification_job
    NotificationBroadcastJob.perform_later(notification)
  end
end