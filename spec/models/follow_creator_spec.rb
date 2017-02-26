require 'rails_helper'

RSpec.describe FollowCreator do
  describe '#create' do
    it 'should create a follow' do
      creator = FollowCreator.new(build(:follow))

      expect  { creator.create }.to change{ Follow.count }.from(0).to(1)
    end

    it 'should notify' do
      allow(NotificationCreator).to receive(:new).and_return(NotificationCreator.new(build(:notification)))
      allow_any_instance_of(NotificationCreator).to receive(:create).and_return(true)

      FollowCreator.new(build(:follow)).create
      expect(NotificationCreator).to have_received(:new)
    end
  end
end
