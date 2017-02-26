class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.includes(:owner).page params[:page]
    NotificationReaderService.read_notifications_for current_user
  end
end