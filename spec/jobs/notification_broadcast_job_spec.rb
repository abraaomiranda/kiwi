require 'rails_helper'

RSpec.describe NotificationBroadcastJob, type: :job do
  include ActiveJob::TestHelper

  let!(:notification) { create :notification}
  subject(:job) { described_class.perform_later(notification) }

  describe '#perform' do
    it 'queues the job' do
      expect { job }
          .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'is in default queue' do
      expect(NotificationBroadcastJob.new.queue_name).to eq('default')
    end

    it 'executes perform' do
      expect(NotificationService).to receive(:render_notification).with(notification)
      perform_enqueued_jobs { job }
    end
  end
  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
