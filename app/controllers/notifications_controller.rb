class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.includes(:owner)
    @notifications.update_all(read: true)
  end
end