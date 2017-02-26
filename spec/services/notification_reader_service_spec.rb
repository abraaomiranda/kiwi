require 'rails_helper'

RSpec.describe NotificationReaderService do
  describe '#read_notifications_for' do
    it 'should read all unread notifications for user' do
      notification = create :notification

      expect{NotificationReaderService.read_notifications_for(notification.recipient)}.
          to change{Notification.where(read:true).count}.by(1)
    end
  end
end
