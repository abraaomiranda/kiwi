require 'rails_helper'

RSpec.describe NotificationCreator do
  describe '#create' do
    it 'should create a notification' do
      creator = NotificationCreator.new build(:notification)

      expect {creator.create}.to change {Notification.count}.from(0).to(1)
    end

    it 'should create a job' do
      notification = build(:notification)

      expect(NotificationBroadcastJob).to receive(:perform_later).with(notification)
      NotificationCreator.new(notification).create
    end
  end
end
