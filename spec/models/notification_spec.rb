require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { build :notification }

  describe 'associations' do
    it { should belong_to(:owner).class_name('User') }
    it { should belong_to(:recipient).class_name('User') }
  end

  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:message) }
      it { should validate_presence_of(:reference_id) }
      it { should validate_presence_of(:reference_class) }
    end
  end

  describe '#reference' do
    it 'should return the reference of a follow' do
      user = create :user
      notification = create :notification, owner: user

      expect(notification.reference).to eql user
    end
  end
end
