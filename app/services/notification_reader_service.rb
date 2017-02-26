class NotificationReaderService
  def self.read_notifications_for(user)
    user.notifications.where(read:false).update(read: true)
  end
end