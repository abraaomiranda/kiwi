require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build :post }

  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('user_id') }
  end

  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:author) }
      it { should validate_presence_of(:content) }
    end

    context 'length' do
      it { should validate_length_of(:content).is_at_most(140) }
    end
  end

  describe 'delegations' do
    it { should delegate_method(:username).to(:author).with_prefix(true) }
    it { should delegate_method(:name).to(:author).with_prefix(true) }
  end

  describe 'scopes' do
    describe '.default_scope' do
      it 'order posts by created_at desc' do
        previous_post = create :post, created_at: 1.hour.ago
        recent_post = create :post

        expect(Post.first).to eql recent_post
      end
    end
  end
end
