require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:follow) { build :follow }

  describe 'associations' do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followed).class_name('User') }
  end

  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:follower_id) }
      it { should validate_presence_of(:followed_id) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:followed_id).scoped_to(:follower_id) }
    end
  end
end
