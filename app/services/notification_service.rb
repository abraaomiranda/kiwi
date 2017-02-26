class NotificationService
  def self.render_notification(notification)
    ActionCable.server.broadcast 'notification_channel',
                                 notification: notification_rendered(notification)
  end

  private

  def self.notification_rendered(notification)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
  end
end