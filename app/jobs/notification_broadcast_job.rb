class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(*args)
    NotificationService.render_notification(args[0])
  end
end
