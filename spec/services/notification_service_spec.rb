require 'rails_helper'

RSpec.describe NotificationService do
  describe '#render_notification' do
    it 'should render a notification' do
      notification = create :notification

      expect(ActionCable.server).to receive(:broadcast)
      NotificationService.render_notification(notification)
    end
  end
end
